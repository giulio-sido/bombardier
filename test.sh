#!/bin/bash

# number of loops/prints for each load:
# 0: html
# 1: 10000/1000
# 2: 50000/10000
# 3: 100000/10000
# 5: 300000/100000
# 20: 1000000/100000

conn=20

for j in {1..20}
do
    if [ $(($j%2)) -eq 0 ];
    then
        echo "without ebpf...";
        ssh giu_sido@fc12::2 /users/giu_sido/eip-ml-ebpf/detach-ebpf.sh;
        pre=$1-;
    else
        echo "with ebpf...";
        ssh giu_sido@fc12::2 "cd /users/giu_sido/eip-ml-ebpf/ && ./restart-ebpf.sh";
        pre=ebpf-$1-
    fi
    for i in {1..50}
    do
        # for conn in {1..60} `seq 62 2 100` `seq 105 5 200`
        # for conn in {1..60} `seq 62 2 80`
        # do
        echo "Loop: " $j " - " $i ", number of connections: " $conn
        req=$(($conn * 100))
        # if [ -z $1 ]
        # then
        #     pre=''
        # else
        #     pre=$1-
        # fi
        ./bombardier -c $conn -n $req -o csv -x $pre$conn.csv http://[fc12::2]
        # done
    done
done
