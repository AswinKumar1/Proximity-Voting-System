#!/bin/bash

echo "Running Proximity in shell...... Ashwin"
if [ ! -e /sys/class/gpio/gpio68/value ]
then
  echo 68 > /sys/class/gpio/export
  echo out  > /sys/class/gpio/gpio68/direction
  echo "output_done"
fi

if [ ! -e /sys/class/gpio/gpio44/value ]
then
  echo 44 > /sys/class/gpio/export
  echo in > /sys/class/gpio/gpio44/direction
  echo "input_done"
fi

file=/sys/class/gpio/gpio44/value
#count_file=/proximity/count.txt

#like=`cat "$file"`
count=`cat /test/count.txt`
log=$(date +"%d-%m-%Y_%H:%M:%S")
echo "$like"
status=0

while [ : ]
do
  if [ $count -eq 0 ];
  then
     echo $last_count > $count
  fi
  like=`cat "$file"`
  if [ "$like" == "0" ];
  then
   if [ "$pid" == "" ];
   then
     if [ "$status" == "0" ];
     then
      count=$(($count+1))
	  last_count=$count
      echo "$count" > /proximity/count.txt
      echo "$log" >> /proximity/log.txt
      echo 1 > /sys/class/gpio/gpio68/value
      sleep 4
      echo 0 > /sys/class/gpio/gpio68/value
      status=1
     fi
    fi
  else
   status=0
  fi
 done


