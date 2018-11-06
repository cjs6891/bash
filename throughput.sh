#!/bin/bash

# byte(s)/second --to--> Megabit(s)/second [Mbps]
# Formula: Divide (byte(s)/second / 125000)
# 125000 [byte(s)/second] == 1 [Megabit(s)/second]

# byte(s)/second --to--> Gigabit(s)/second [Gbps]
# Formula: Divide (byte(s)/second / 125000000)
# 125000000 [byte(s)/second] == 1 [Gigabit(s)/second]

# 1000 [Megabit(s)/second] == 125 [Megabyte(s)/second]
#    1 [Gigabit(s)/second] == 125 [Megabyte(s)/second]

if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

IF=$1

while true
do
        rx_bytes1=`cat /sys/class/net/$1/statistics/rx_bytes`
        tx_bytes1=`cat /sys/class/net/$1/statistics/tx_bytes`
        sleep 1
        rx_bytes2=`cat /sys/class/net/$1/statistics/rx_bytes`
        tx_bytes2=`cat /sys/class/net/$1/statistics/tx_bytes`

        rx_bytes=$(($rx_bytes2 - $rx_bytes1))
        tx_bytes=$(($tx_bytes2 - $tx_bytes1))

        rx_Mbps=`echo "scale=2; $rx_bytes/125000" | bc -l | awk '{printf "%.2f\n", $0}'`
        tx_Mbps=`echo "scale=2; $tx_bytes/125000" | bc -l | awk '{printf "%.2f\n", $0}'`

        echo "rx: $rx_Mbps | tx: $tx_Mbps"
done
