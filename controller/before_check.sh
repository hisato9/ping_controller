#!/bin/bash

# set remote host list file(relative path)
hostlistfile="./remotehostlist.lst"

# loop execution for each host in hostlist file
while read line
do
  # execute with sshpass to remote host
  check_result=`nc -z "$line" 22 2>&1`
  if [ -n "$check_result" ]; then
    result="${line}:OK"
    array=("${array[@]}" $result)
  fi
done < $hostlistfile

# display check result
IFS=$'\n'
echo "${array[*]}"