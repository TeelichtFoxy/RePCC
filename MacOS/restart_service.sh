#!/bin/bash

SERVICE_PLIST=~/Library/LaunchAgents/eskibb.REPCCService.plist
SERVICE_LABEL="eskibb.REPCCService"

echo "--- RE/STARTING REPCC Service ---"

launchctl unload $SERVICE_PLIST
echo "Service stopped..."

sleep 1

launchctl load $SERVICE_PLIST
echo "Service started..."

launchctl list | grep "$SERVICE_LABEL"

echo "--- Restart complete. See logs for details: ---"
echo "tail -f /tmp/eskibb_service.log"
