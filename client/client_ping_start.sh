#!/bin/sh

# set execution date for logfile name
exec_date=`date +"%Y%m%d"`
# define begin message for log
start_echo="### Test No.$1 Begin ###"
# set logfile directory(relative path)
hostlistfile="./targethostlist.lst"

# chage directory to /tmp
cd /tmp
# loop execution for each host in hostlist file
while read line
do
  # set logfile name
  log=$1_"$line"_$exec_date.log
  # write execution date & time into logfile
  date +"%Y/%m/%d %I:%M:%S" > ./log/$log &
  # write bgin message into logfile(append)
  echo $start_echo >> ./log/$log &
  # execute ping & write the result into logfile(append)
  ping $line | awk '{print strftime("%Y%m%d %H:%M:%S"), $0}' >> ./log/$log &
done < $hostlistfile