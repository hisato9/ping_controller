#!/bin/bash

# define loginuser name
loginuser=[your login user]
# define loginuser password
loginpassword=[your login password]
# set the execution shell script file(full path) for remote hosts
script1="/tmp/ping_cs/client/client_ping_start.sh"
script2="/tmp/ping_cs/client/client_ping_stop.sh"
host="/tmp/ping_cs/client/targethostlist.lst"
# set remote host list file(relative path)
hostlistfile="./remotehostlist.lst"

# loop execution for each host in hostlist file
while read line
do
  # execute with sshpass to remote host
  sshpass -p $loginpassword scp '-o' StrictHostKeyChecking=no $script1 $script2 $host $loginuser@$line:/tmp
  exec_code=$?
  if [ $exec_code -eq 0 ]; then
    result="${line}:OK"
    array=("${array[@]}" $result)
  fi
done < $hostlistfile

# display check result
IFS=$'\n'
echo "${array[*]}"