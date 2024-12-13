#!/bin/bash
set -e  # Abort script on any error
set -o pipefail  # Ensure pipeline commands return proper error codes

# Define file paths
SRC_FILE="/usr/src/app/scripts/state.json"
DEST_FILE="/usr/src/app/reports/state.json"
LOG_DIR="/var/log"
LOG_FILE="$LOG_DIR/initialsync.log"

# Ensure required directories exist
mkdir -p /usr/src/app/reports
mkdir -p "$LOG_DIR"

# Copy source file to destination if it does not exist
if [ ! -f "$DEST_FILE" ]; then
    echo "Copying initial state file to reports directory..."
    cp "$SRC_FILE" "$DEST_FILE"
fi

# Wait for any dependencies (if necessary)
sleep 20

# Log start of initial pull
echo "Initial Pull: Starting" | tee -a "$LOG_FILE"
date | tee -a "$LOG_FILE"

/usr/local/bin/python /usr/src/app/scripts/VickyTopiaReportCLI.py --allreports >> "$LOG_FILE" 2>&1

# Log completion of initial pull
echo "Initial Pull: Completed" | tee -a "$LOG_FILE"
date | tee -a "$LOG_FILE"

# Start the main launcher script
echo "Starting Scheduler..." | tee -a "$LOG_FILE"
date | tee -a "$LOG_FILE"

# Run launcher script in the foreground or background based on requirements
exec /usr/local/bin/python /usr/src/app/scripts/launcher.py
