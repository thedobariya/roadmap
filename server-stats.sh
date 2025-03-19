#!/bin/bash

echo "================ System Resource Usage ================"
echo "=== CPU Usage ==="
# Get total CPU usage percentage
# top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Usage: " (100 - $1) "%"}'
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Total CPU Usage: $CPU_USAGE"

echo "=== Total Memory usage percentage ==="
# Get total memory usage percentage (free vs used inlcuding percentage)
# free | grep Mem | awk '{print "Memory Usage: " $3/$2 * 100.0 "%"}'
MEMORY=$(free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2}')
echo "Total Memory Usage: $MEMORY"

echo "=== Disk Usage ==="
# Get total disk usage percentage (free vs used inlcuding percentage)
# df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB %s\n", $3,$2,$5}'
DISK=$(df -h --total | grep "total" | awk '{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $5}')
echo "Total Disk Usage: $DISK"


echo "======================================================="

echo "=== Top Processes ==="
# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo "======================================================="

echo "=== Top 5 Processes by Memory Usage ==="
# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6