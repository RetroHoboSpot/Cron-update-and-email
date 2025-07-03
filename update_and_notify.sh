#!/bin/bash

# System info
HOSTNAME=$(hostname)
OS_VERSION=$(lsb_release -d | cut -f2)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Update system
apt update && apt upgrade -y

# Capture the output
LOGFILE="/var/log/update_$(date +%F).log"
apt list --upgradable > "$LOGFILE"

# Email settings
TO="recipient@example.com"
FROM="your_username@example.com"
SUBJECT="Ubuntu Server Update Completed on $HOSTNAME"

# Compose the email
{
  echo "To: $TO"
  echo "From: $FROM"
  echo "Subject: $SUBJECT"
  echo "Content-Type: text/plain"
  echo ""
  echo "System update completed on:"
  echo "Hostname: $HOSTNAME"
  echo "OS Version: $OS_VERSION"
  echo "IP Address: $IP_ADDRESS"
  echo ""
  echo "Update Log:"
  cat "$LOGFILE"
} | sendmail -t
