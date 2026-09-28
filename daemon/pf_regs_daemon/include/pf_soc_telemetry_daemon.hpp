#ifndef PF_SOC_TELEMETRY_DAEMON
#define PF_SOC_TELEMETRY_DAEMON

#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <cstdint>
#include <memory>
#include <string>
#include <vector>
#include <mutex>
#include <condition_variable>
#include <atomic>
#include <cstdlib>

// Character device driver wrapper class (RAII)
class RegisterMap {
private:
    int fd_ = -1; // filde descriptor
    std::string device_path_; //

public:
    explicit RegisterMap(const std::string& device_path) : device_path_(device_path) {
        // Open character device created by kernel driver
        fd_ = open(device_path_.c_str(), O_RDWR);

        if (fd_ < 0) {
            std::cerr << "[ERROR] Could not open device file " << device_path_ << ".\n";
            std::cerr << "[INFO] Falling back to Mock Telemetry Mode.\n";
        } else {
            std::cout << "[SUCCESS] Opened kernel driver interface: " << device_path_ << "\n";
        }
    }

    ~RegisterMap() {
        if (fd_ >= 0) {
            close(fd_);
            std::cout << "[INFO] Driver device node closed by RAII destructor.\n";
        }
    }

    // RAII ownership guard
    RegisterMap(const RegisterMap&) = delete; // disables copy constructor
    RegisterMap& operator=(const RegisterMap&) = delete; // disables copy assignment

    // move Semantics
    RegisterMap(RegisterMap&& other) noexcept : fd_(other.fd_), device_path_(std::move(other.device_path_)) {
        other.fd_ = -1; // instead of copying, transfer ownership
    }

    // Read 32-bit value at register offset with pread
    uint32_t read32(size_t offset) const {
        if (fd_ < 0) {
            // mock mode: simulated telemetry stream (TODO: remove!!!)
            return static_cast<uint32_t>(500 + (rand() % 50));
        }

        uint32_t value = 0;
        ssize_t bytes_read = pread(fd_, &value, sizeof(value), static_cast<off_t>(offset));

        if (bytes_read != sizeof(value)) {
            std::cerr << "[ERROR] Driver read failed at offset 0x" << std::hex << offset << std::dec << "\n";
            return 0;
        }

        return value;
    }

    // Write 32-bit value at register offset with pwrite
    void write32(size_t offset, uint32_t value) {
        if (fd_ < 0) return;

        ssize_t bytes_written = pwrite(fd_, &value, sizeof(value), static_cast<off_t>(offset));
        if (bytes_written != sizeof(value)) {
            std::cerr << "[ERROR] Driver write failed at offset 0x" << std::hex << offset << std::dec << "\n";
        }
    }

    bool is_mock() const { return fd_ < 0; }
};

// Thread-safe ring buffer (producer/consumer)
template <typename T>
class ConcurrentRingBuffer {
private:
    std::vector<T> buffer_;
    size_t capacity_;
    size_t head_ = 0;
    size_t tail_ = 0;
    size_t count_ = 0;

    mutable std::mutex mutex_;
    std::condition_variable cv_not_full_;
    std::condition_variable cv_not_empty_;

public:
    explicit ConcurrentRingBuffer(size_t capacity) : buffer_(capacity), capacity_(capacity) {}

    void push(const T& item) {
        std::unique_lock<std::mutex> lock(mutex_);
        cv_not_full_.wait(lock, [this]() { return count_ < capacity_; });

        buffer_[head_] = item;
        head_ = (head_ + 1) % capacity_;
        ++count_;

        lock.unlock();
        cv_not_empty_.notify_one();
    }

    T pop() {
        std::unique_lock<std::mutex> lock(mutex_);
        cv_not_empty_.wait(lock, [this]() { return count_ > 0; });

        T item = buffer_[tail_];
        tail_ = (tail_ + 1) % capacity_;
        --count_;

        lock.unlock();
        cv_not_full_.notify_one();
        return item;
    }
};

#endif
