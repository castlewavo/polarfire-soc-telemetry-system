#include "pf_soc_telemetry_daemon.hpp"
#include <iostream>
#include <csignal>
#include <numeric>
#include <vector>
#include <thread>
#include <chrono>
#include <pthread.h>
#include <sched.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

std::atomic<bool> running{true};

void signal_handler(int signal) {
    if (signal == SIGINT || signal == SIGTERM) {
        running = false;
    }
}

struct TelemetryPacket {
    uint64_t timestamp_ms;
    uint32_t raw_value;
};

// Register offsets defined in Libero IP
namespace {
    constexpr size_t OFFSET_DATA_IN = 0x04;
    constexpr size_t OFFSET_HW_ID   = 0x1C;
}

int main(int argc, char* argv[]) {
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    sockaddr_in dest_addr{};
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port = htons(9870);
    dest_addr.sin_addr.s_addr = inet_addr("127.0.0.1");

    std::signal(SIGINT, signal_handler);
    std::signal(SIGTERM, signal_handler);

    std::cout << " PolarFire SoC C++ Telemetry Daemon (Driver Mode)  \n";

    // Device node
    // Can pass device path via command line or default
    std::string device_node = (argc > 1) ? argv[1] : "/dev/pf_regs";

    // Instantiate driver hardware interface wrapper
    auto hw = std::make_unique<RegisterMap>(device_node); //smart pointer just for education purposes, not really necesssary
    ConcurrentRingBuffer<TelemetryPacket> ring_buffer(100);

    // Producer thread: ppins to CPU Core 1 and samples driver at 100Hz
    std::thread producer([&]() {
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(1, &cpuset);
        int rc = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
        if (rc != 0) {
            std::cerr << "[ERROR] Could not pin Producer thread to CPU Core 1\n";
        }

        // Read HW_ID register via driver
        uint32_t hw_id = hw->read32(OFFSET_HW_ID);
        std::cout << "[INIT] Identified FPGA Peripheral HW_ID: 0x"
        << std::hex << hw_id << std::dec << " (Core 1)\n";

        uint64_t ms_counter = 0;
        while (running) {
            uint32_t val = hw->read32(OFFSET_DATA_IN);
            ring_buffer.push({ms_counter, val});

            ms_counter += 10;
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
    });

    // Consumer thread: processing and moving average DSP filter
    std::thread consumer([&]() {

        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(2, &cpuset);
        int rc = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
        if (rc != 0) {
            std::cerr << "[ERROR] Could not pin Consumer thread to CPU Core 2\n";
        }

        std::vector<uint32_t> window;
        constexpr size_t WINDOW_SIZE = 10;

        while (running) {
            TelemetryPacket pkt = ring_buffer.pop();

            window.push_back(pkt.raw_value);
            if (window.size() > WINDOW_SIZE) {
                window.erase(window.begin());
            }

            double avg = std::accumulate(window.begin(), window.end(), 0.0) / window.size();

            std::cout << "[TIME " << pkt.timestamp_ms << " ms] "
            << "Driver Val: " << pkt.raw_value
            << " | Moving Avg: " << avg << "\n";

            std::string msg = std::to_string(pkt.timestamp_ms) + "," +
            std::to_string(pkt.raw_value) + "," +
            std::to_string(avg) + "\n";
            sendto(sock, msg.c_str(), msg.length(), 0, (struct sockaddr*)&dest_addr, sizeof(dest_addr));
        }
    });

    // Shutdown
    if (producer.joinable()) producer.join();
    if (consumer.joinable()) consumer.join();

    close(sock);
    std::cout << " Daemon stopped cleanly.\n";

    return 0;
}
