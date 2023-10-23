#!/bin/bash

# number of loops/prints for each load:
# 0: html
# 1: 10000/1000
# 2: 50000/10000
# 3: 100000/10000
# 5: 300000/100000
# 20: 1000000/100000

for i in {1..30}
do
    # for conn in {1..60} `seq 62 2 100` `seq 105 5 200`
    for conn in {1..60} `seq 62 2 80`
    do
        echo "Loop: " $i ", number of connections: " $conn
        req=$(($conn * 100))
        if [ -z $1 ]
        then
            pre=''
        else
            pre=$1-
        fi
        ./bombardier -c $conn -n $req -o csv -x $pre$conn.csv http://[fc12::2]
    done
done
