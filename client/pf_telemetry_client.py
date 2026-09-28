#!/usr/bin/env python3
import socket

UDP_IP = "127.0.0.1"
UDP_PORT = 9870

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((UDP_IP, UDP_PORT))
    print(f"[NET] Telemetry client listening on {UDP_IP}:{UDP_PORT}...")

    try:
        while True:
            data, _ = sock.recvfrom(1024)
            payload = data.decode('utf-8').strip()

            # CSV payload: timestamp_ms, raw_val, moving_avg
            parts = payload.split(',')
            if len(parts) == 3:
                ts, raw_val, avg = parts
                print(f"[STREAM] Time: {ts:>6} ms | Raw: {raw_val:>5} | Moving Avg: {float(avg):>7.2f}")
    except KeyboardInterrupt:
        print("\n[INFO] Client stopped.")
    finally:
        sock.close()

if __name__ == "__main__":
    main()
