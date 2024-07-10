# Scheduled Archiver
Bash archiver, scheduled to run every 24 hours.
 ### Steps to run
 1. Allow execution privileges: `chmod +x backup.sh`
 2. Enable scheduler: `crontab -e`
 3. Paste at the bottom of the file: `0 0 * * * backup.sh [target-direcory] [destination-directory]` (use sudo if needed)
 4. Save file with `ctrl+x`
