#!/bin/bash

SERVICE_PLIST=~/Library/LaunchAgents/eskibb.REPCCService.plist
SERVICE_LABEL="eskibb.REPCCService"

echo "--- STOPPING REPCC Service ---"

launchctl unload $SERVICE_PLIST

echo "Plist unloaded..."

launchctl stop $SERVICE_LABEL

echo "Service stopped..."

launchctl list | grep $SERVICE_LABEL

echo "--- Stopping complete. ---"