#!/bin/bash

# Define the cron job with PATH set separately.
cron_job="PATH=/usr/local/bin:/usr/bin:/bin\n0 9 * * * /replace/with/the/path/to/your/runChangeQuote.sh/file"

# Add the job to root's crontab (using sudo) if it’s not already present
(sudo crontab -l 2>/dev/null; echo -e "$cron_job") | grep -v -F "$cron_job" | sudo crontab -

# 9:00 am every day
#PATH=/usr/local/bin:/usr/bin:/bin
#0 9 * * * /replace/with/the/path/to/your/runChangeQuote.sh/file