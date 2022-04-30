#!/bin/bash
#cpuuse=$(top -n 1 | grep %Cpu | awk '{print $2}'|cut -f 1 -d ".")

while true;
do
    cpuuse=$(top -n 1 | grep -A 1 %MEM | awk '{print $10}' | tail -n 1|cut -f 1 -d ".")
    MESSAGE="/tmp/cpulogs.log"
    if [ "$cpuuse" -ge 1 ]; then
        echo "" >> $MESSAGE
        echo "=========================================================================================================" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "$(date) : CPU current usage is: $cpuuse%" >> $MESSAGE
        echo "---------------------------------------------------------------------------------------------------------" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "Top 20 Processes using top command" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "$(top -bn1 | head -20)" >> $MESSAGE
        echo "---------------------------------------------------------------------------------------------------------" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "Top 20 Processes using ps command" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "$(ps -eo pcpu,pid,user,args | sort -k 1 -r | head -20)" >> $MESSAGE
        echo "---------------------------------------------------------------------------------------------------------" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "Top 20 IO Consume using iotop command" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "$(sudo iotop -botqqq --iter=3| head -20)" >> $MESSAGE
        echo "" >> $MESSAGE
        echo "=========================================================================================================" >> $MESSAGE
    else
        echo "Server CPU usage is in under threshold"
    fi
    echo "one"
done
