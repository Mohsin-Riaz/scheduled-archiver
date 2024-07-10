#!/bin/bash

# --SCHEDULED ARCHIVER--

# Execution priviledges needed, run chmod +x backup.sh

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

targetDirectory=$1
destinationDirectory=$2

echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

currentTS=$(date +%s)	# current timestamp

backupFileName="backup-$currentTS.tar.gz"	# backup filename with timestamp

origAbsPath=`pwd`		# parent absolute path

cd $destinationDirectory
destDirAbsPath=`pwd`	  # destination absolute path

cd $origAbsPath
cd $targetDirectory		# go to target path for file search

yesterdayTS=$(($currentTS - 24 * 60 * 60)) 

declare -a toBackup		# create backups file array

for file in $(ls)	 # loop through all files
do
  if ((`date -r $file +%s` > $yesterdayTS)) 	# checks if file date is later than backup 24 hours ago
  then
    toBackup+=($file)	# append all newer files to array
  fi
done


tar -czvf $backupFileName ${toBackup[@]}	# creates tar


mv $backupFileName $destDirAbsPath	# move backup to Destination directory

