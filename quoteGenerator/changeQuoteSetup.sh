#!/bin/bash

# get parent directory of script
parent_dir=$(cd "$(dirname "$0")" && pwd)

# make runChangeQuote.sh executable
chmod +x $parent_dir/runChangeQuote.sh

# Define the cron job with PATH set separately.
cron_job="PATH=/usr/local/bin:/usr/bin:/bin\n0 9 * * * $parent_dir/runChangeQuote.sh"

# Add the job to root's crontab (using sudo) if it’s not already present
(sudo crontab -l 2>/dev/null; echo -e "$cron_job") | grep -v -F "$cron_job" | sudo crontab -

# 9:00 am every day
#PATH=/usr/local/bin:/usr/bin:/bin
#0 9 * * * /Users/rowan/automations/quoteGenerator/runChangeQuote.sh
