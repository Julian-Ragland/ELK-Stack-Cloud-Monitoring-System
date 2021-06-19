#1/bin/bash

cat  0310_Dealer_schedule 0312_Dealer_schedule 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' > Dealer_Schedules.txt

grep 'Billy' Dealer_Schedules.txt > Dealer_Times.txt






