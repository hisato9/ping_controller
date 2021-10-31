#!/bin/bash

# define loginuser name
loginuser=[your login user]
# define loginuser password
loginpassword=[your login password]
# set the execution shell script file(full path) in remote hosts
command="/tmp/client_ping_stop.sh"
# set remote host list file(relative path)
hostlistfile="./remotehostlist.lst"

# loop execution for each host in hostlist file
while read line
do
  # execute with sshpass to remote host
  sshpass -p $loginpassword ssh '-o' StrictHostKeyChecking=no $loginuser@$line $command $1
done < $hostlistfile