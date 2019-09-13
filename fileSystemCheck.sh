#!/bin/bash
# Script to continuously check Filesystem and
# print only those where size has increased
#

while IFS= read line; 
  do a=$(echo $line| awk '{print $1}') 
    b=$(echo $line| awk '{print $2}')
    c=$(df -Pm| grep ${a}$ | awk '{print $4}')
     if [[ $c > $b ]] ; 
     then df -Pm| grep ${a}$ | awk '{print $6, $4}'
      fi ;
   done </tmp/list ;  
  df -Pm| awk '{print $6, $4}'| grep -v Available> /tmp/list
