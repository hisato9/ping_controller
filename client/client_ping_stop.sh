#!/bin/sh

# set execution date for logfile name
exec_date=`date +"%Y%m%d"`
# define end message for log
end_echo="### Test No.$1 End ###"
# set logfile directory(relative path)
hostlistfile="./targethostlist.lst"

# chage directory to /tmp
cd /tmp
# loop execution for each host in hostlist file
while read line
do
  # set logfile name
  log=$1_"$line"_$exec_date.log
  # lookup & kill the process to ping
  ps aux | grep $line | grep -v grep | awk '{ print "kill -15", $1 }' | sh &
  # write end message into logfile(append)
  echo $end_echo >> ./log/$log &
  # write end date & time into logfile(append)
  date +"%Y/%m/%d %I:%M:%S" >> ./log/$log &
done < $hostlistfile