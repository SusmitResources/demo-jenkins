#!/bin/bash

LOGFILE="$(pwd)/network_health_$(date +%F).log"

echo "=========================================" | tee -a "$LOGFILE"
echo " Network Health Check - $(date)" | tee -a "$LOGFILE"
echo "=========================================" | tee -a "$LOGFILE"

# Hostname and IP
echo -e "\n[Hostname & IP]" | tee -a "$LOGFILE"
hostname | tee -a "$LOGFILE"
ip -br a | tee -a "$LOGFILE"

# Default Gateway
echo -e "\n[Default Gateway]" | tee -a "$LOGFILE"
ip route | grep default | tee -a "$LOGFILE"

# Internet Connectivity
echo -e "\n[Internet Connectivity Check]" | tee -a "$LOGFILE"
ping -c 3 8.8.8.8 &>/dev/null
if [ $? -eq 0 ]; then
    echo "Internet: OK" | tee -a "$LOGFILE"
else
    echo "Internet: FAILED" | tee -a "$LOGFILE"
fi

# DNS Resolution
echo -e "\n[DNS Resolution Check]" | tee -a "$LOGFILE"
nslookup google.com &>/dev/null
if [ $? -eq 0 ]; then
    echo "DNS: OK" | tee -a "$LOGFILE"
else
    echo "DNS: FAILED" | tee -a "$LOGFILE"
fi

# Port Checks
echo -e "\n[Port Availability]" | tee -a "$LOGFILE"
for PORT in 22 80 443 8080; do
    ss -lnt | grep -q ":$PORT "
    if [ $? -eq 0 ]; then
        echo "Port $PORT: LISTENING" | tee -a "$LOGFILE"
    else
        echo "Port $PORT: NOT LISTENING" | tee -a "$LOGFILE"
    fi
done

# Active Connections
echo -e "\n[Active Network Connections]" | tee -a "$LOGFILE"
ss -s | tee -a "$LOGFILE"

echo -e "\nNetwork check completed." | tee -a "$LOGFILE"
