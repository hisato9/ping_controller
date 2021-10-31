#!/bin/bash

# define loginuser name
loginuser=[your login user]
# define loginuser password
loginpassword=[your login password]
# set log directory
logdir="./log"
# set remote host list file(relative path)
hostlistfile="./remotehostlist.lst"

# check whether log directory exists or not, if not make log directory
if [ ! -d $logdir ]; then
  mkdir $logdir
fi

# loop execution for each host in hostlist file
while read line
do
  # check whether sub directory exists or not, if not make sub directory
  subdir=$logdir"/"$line
  if [ ! -d $subdir ]; then
    mkdir $subdir
  fi
  # execute with sshpass to remote host
  sshpass -p $loginpassword scp '-o' StrictHostKeyChecking=no $loginuser@$line:/tmp/log $subdir
  exec_code=$?
  if [ $exec_code -eq 0 ]; then
    result="${line}:OK"
    array=("${array[@]}" $result)
  fi
done < $hostlistfile

# display check result
IFS=$'\n'
echo "${array[*]}"