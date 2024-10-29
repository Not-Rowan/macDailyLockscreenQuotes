#!/bin/bash

# unload plist
if ! sudo launchctl bootout system /Library/LaunchDaemons/com.rowan.lockscreenQuote.plist; then
    echo "error "
fi

# delete lockscreenQuote folder
rm -r '/Library/Application Support/lockscreenQuote'

echo "lockscreenQuote has been removed from the system"