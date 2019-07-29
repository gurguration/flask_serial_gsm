#!/bin/bash

echo Starting Connection Check...

if [ $# -lt 1 ]; then
   echo "unda gadmomeces TTL-is mnishvneloba"
   exit 1
fi

INT='^[0-9]+$'

if ! [[ $1 =~ $INT ]]; then
   echo "gadmocemuli parametri unda iyos dadebiti ricxvi"
   exit 1
fi

declare -i TTL=$1
declare -i MAX=$TTL+5
declare -i MIN=$TTL-5
declare -i MAXSEND=0
declare -i MINSEND=0
declare -i OKSEND=0

while true;
   do
       sleep 5
       declare -i NEWTTL=`ping -c 1 8.8.8.8 | grep "time=" | awk '{print $7}' | awk -F= '{print $2}' | awk -F. '{print $1}'`
       if [ $NEWTTL -ge $MAX ]; then
           if [ $MAXSEND = 1 ]; then
               echo "araferi shecvlila vagrdzeleb $NEWTTL"
               continue
               #echo gagzavnilia: time+5 metia: $NEWTTL | tee /dev/null
           else
               MAXSEND=1
               MINSEND=0
               OKSEND=0
               echo "TTL Normaze magalia gaigzavnos maili: $NEWTTL" | tee -a /tmp/ping
           fi
       elif [ $NEWTTL -le $MIN ]; then              
           if [ $MINSEND = 1 ]; then
               echo "araferi shecvlila vagrdzeleb $NEWTTL"
               continue
               #echo gagzavnilia: time-5 naklebia: $NEWTTL |tee /dev/null
           else
               MINSEND=1
               MAXSEND=0
               OKSEND=0
               echo "TTL IS Low: $NEWTTL gaigzavnos maili" | tee -a /tmp/ping
           fi

       else
           if [ $OKSEND = 1 ]; then
               echo "araferi shecvlila vagrdzeleb $NEWTTL"
               continue
               #echo gagzavnilia: time normis farglebshia: $OKSEND | tee /dev/null
           else
               MINSEND=0
               MAXSEND=0
               OKSEND=1
               echo "TTL IS OK gaigzavnos maili: $NEWTTL" | tee -a /tmp/ping
           fi
       fi
       
   done