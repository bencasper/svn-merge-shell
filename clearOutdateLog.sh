#bin/bash
DIRS="/letv/logs/"

LOG_FILE="/letv/logs/delOutdateLog.log"

TIMESTAMP=`date +%Y:%m:%d`

MINUTES_AGO="+360" # This will find and delete folders and files older than 6*60 minuts ago.
REG_PATTERN='.*\.log.*' #This will find file which name contain '.log'
IFS=$','

if [ ! -f $LOG_FILE ]
then
	echo 'creaet log file at: '$TIMESTAMP > $LOG_FILE	
fi


echo "....................................." >> $LOG_FILE

echo "Starting Deletion job on : $TIMESTAMP" >> $LOG_FILE

for DIR in $DIRS

do
if [ -d "$DIR" ]; then

echo "Looking for Files in $DIR" >> $LOG_FILE
echo "find $DIR -type f -mmin $MINUTES_AGO -regex $REG_PATTERN" >> $LOG_FILE
find $DIR -type f -mmin $MINUTES_AGO -regex $REG_PATTERN >> $LOG_FILE

find $DIR -type f -mmin $MINUTES_AGO -regex $REG_PATTERN -exec rm -f {} \;
#echo "find $DIR -type f -mtime $DAYS_OLD -regex $REG_PATTERN -exec rm -f {} \;"
echo "Deleted found files" >> $LOG_FILE



fi
done
unset IFS
echo "Cleanup on $NOW completed" >> $LOG_FILE

echo "..........................................................">>$LOG_FILE

