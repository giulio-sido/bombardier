#!/bin/bash

for i in {1..10}
do
    for conn in {1..60}
    do
        echo "Loop: " $i ", number of connections: " $conn
        req=$(($conn * 100))
        ./bombardier -c $conn -n $req -o csv -x $conn.csv http://[fc12::2]
    done
done