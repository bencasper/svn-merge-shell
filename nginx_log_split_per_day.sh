#!/bin/bash


logs_path="/letv/logs/nginx"
logs_suffix=".log"

backup_suffix=.$(date -d "yesterday" +"%Y")-$(date -d "yesterday" +"%m")-$(date -d "yesterday" +"%d")
cd $logs_path
for log_file in *.log;do
basename=${log_file%.*}
cp -rp $logs_path/$log_file $logs_path/$basename$logs_suffix$backup_suffix
cat /dev/null > $logs_path/$log_file
echo $log_file
done
