#!/bin/bash

# Define the sink name
SINK="@DEFAULT_SINK@"

# Get current volume
CURRENT_VOLUME=$(pactl get-sink-volume $SINK | awk '{print $5}' | sed 's/%//')

# Define the maximum volume limit
MAX_VOLUME=200

# Calculate the new volume
NEW_VOLUME=$((CURRENT_VOLUME + 2))

# Ensure the new volume does not exceed 200%
if [ "$NEW_VOLUME" -gt "$MAX_VOLUME" ]; then
  NEW_VOLUME=$MAX_VOLUME
fi

# Apply the new volume
pactl set-sink-volume $SINK "${NEW_VOLUME}%"
