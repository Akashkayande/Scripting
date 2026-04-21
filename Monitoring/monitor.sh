#!/bin/bash

set -euo pipefail

if [ ! -f config.sh ]; then
    echo "config.sh not found!"
    exit 1
fi

source config.sh
mkdir -p logs
HOST=$(hostname)
LOG_FILE="logs/monitor-$(date +%Y-%m-%d).log"
LOG_RETENTION_DAYS=7

find logs/ -type f -name "monitor-*.log" -mtime +$LOG_RETENTION_DAYS -delete

trap 'echo "Script failed at line $LINENO" >> $LOG_FILE' ERR

for cmd in top awk free mail df systemctl; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: $cmd not found!"
        exit 1
    fi
done

# Alert Function
send_alert() {
    local MESSAGE=$1

    local TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    echo "$TIMESTAMP  $HOST  ALERT : $MESSAGE" >> "$LOG_FILE"


    echo "$MESSAGE" | mail -s "Server Alert" $EMAIL

    if [ $? -ne 0 ]; then
        echo "$TIMESTAMP : Failed to send email alert" >> "$LOG_FILE"
    fi
}

#  CPU Usage
CPU=$(top -bn1 | awk '/Cpu/ {print int(100 - $8)}') 

# Memory Usage
MEMORY=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}') 

#  Disk Usage
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//') 


TIMESTAMPS=$(date '+%Y-%m-%d %H:%M:%S')

echo "$TIMESTAMPS $HOST CPU:$CPU% MEM:$MEMORY% DISK:$DISK%" >> "$LOG_FILE"

#  CPU Check
if [ "$CPU" -gt "$CPU_THRESHOLD" ]; then
    send_alert "High CPU Usage: $CPU%"
fi

#  Memory Check
if [ "$MEMORY" -gt "$MEMORY_THRESHOLD" ]; then
    send_alert "High Memory Usage: $MEMORY%"
fi

#  Disk Check
if [ "$DISK" -gt "$DISK_THRESHOLD" ]; then
    send_alert "High Disk Usage: $DISK%"
fi

#  Service Monitoring
for SERVICE in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$SERVICE"; then
        send_alert "$SERVICE is DOWN!"
    fi
done