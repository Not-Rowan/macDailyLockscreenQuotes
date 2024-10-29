#!/bin/bash

# Get the parent directory of the script
parent_dir=$(cd "$(dirname "$0")" && pwd)

# Give proper execution permissions to lockscreenDelete.sh
chmod +x "$parent_dir/lockscreenQuoteDelete.sh"

# Move the folder to /Library/Application Support
if sudo cp -r "$parent_dir" "/Library/Application Support/"; then
    echo "Folder copied successfully."
else
    echo "Failed to copy the folder." >&2
    exit 1
fi

# Get python path
if which python3 > /dev/null; then
	pythonPath=$(which python3)
else
	echo "Please install python3"
	exit 1
fi

# Create the plist XML file in /Library/LaunchDaemons folder
cat <<EOL > /Library/LaunchDaemons/com.rowan.lockscreenQuote.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>com.rowan.lockscreenQuote</string>
		
		<key>ProgramArguments</key>
		<array>
			<string>$pythonPath</string>
			<string>/Library/Application Support/lockscreenQuote/lockscreenQuote.py</string>
		</array>

		<key>StartCalendarInterval</key>
		<dict>
			<key>Hour</key>
			<integer>9</integer>
			<key>Minute</key>
			<integer>0</integer>
		</dict>

		<key>RunAtLoad</key>
		<true/>
		
		<key>StandardOutPath</key>
		<string>/tmp/lockscreenQuote.out</string>
		<key>StandardErrorPath</key>
		<string>/tmp/lockscreenQuote.err</string>
	</dict>
</plist>
EOL

# Set ownership and permissions for launchDaemon (readable by all and root perms)
if ! sudo chown root:wheel /Library/LaunchDaemons/com.rowan.lockscreenQuote.plist; then
	echo "Failed to change ownership of the plist file." >&2
	exit 1
fi

if ! sudo chmod 644 /Library/LaunchDaemons/com.rowan.lockscreenQuote.plist; then
	echo "Failed to set permissions on the plist file." >&2
	exit 1
fi

# Load the plist
if sudo launchctl bootstrap system /Library/LaunchDaemons/com.rowan.lockscreenQuote.plist; then
	echo "Launched lockscreenQuote.plist successfully"
else
	echo "Error launching lockscreenQuote.plist" >&2
	exit 1
fi

# 9:00 am every day

echo "lockscreenQuote has been installed on the system. Enjoy!"