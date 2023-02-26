#!/bin/bash

# Set the time interval between scans (in seconds)
interval=1

# Create the input file for tshark
sudo touch /tmp/network_traffic.pcap

# Loop infinitely, monitoring the network at the specified interval
while true; do
  # Capture network traffic and store it in the input file
  echo "Capturing network traffic..."
  timeout $interval tshark -i eth0 -w /tmp/network_traffic.pcap > /dev/null 2>&1

  # Analyze the captured traffic for signs of an attack
  echo "Analyzing network traffic..."
  suspicious_packets=$(tshark -r /tmp/network_traffic.pcap -Y "tcp.flags.syn == 1 and tcp.flags.ack == 0" | grep -oP "(\d+\.){3}\d+" | sort | uniq)

  # If suspicious packets are found, notify the user
  if [ -n "$suspicious_packets" ]; then
    echo "Suspicious traffic detected from the following IP addresses:"
    echo "$suspicious_packets"
    notify-send -u critical "ALERT: Suspicious network traffic detected" "$suspicious_packets"
  else
    echo "No suspicious network traffic detected."
  fi

  # Wait for the specified interval
  echo "Waiting for $interval seconds..."
  sleep "$interval"
done
