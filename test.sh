#!/bin/bash

for i in {1..10}
do
    for conn in {1..60} 65 70 75 80 85 90 95 100 110 120 130 140 150;
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
