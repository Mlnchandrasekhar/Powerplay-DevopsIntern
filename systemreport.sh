#!/bin/bash

echo "===== System Report ====="
echo "Date & Time: $(date)"

echo "Uptime: $(uptime -p)"

# CPU
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE%"

# Memory
echo "Memory Usage:"
free -h

# Disk
echo "Disk Usage:"
df -h /

# Top processes
echo "Top 3 Processes by CPU:"
ps aux --sort=-%cpu | head -n 4

echo "==========================="
