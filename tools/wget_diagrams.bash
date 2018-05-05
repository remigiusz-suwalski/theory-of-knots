#!/bin/bash
diagrams=([3]="1" [4]="1" [5]="2" [6]="3" [7]="7" [8]="21" [9]="49" [10]="165")

for crossing in "${!diagrams[@]}"; do
    for ((i=1;i<=${diagrams[$crossing]};i++)); do
    	wget --wait=10 --random-wait \
            "http://www.indiana.edu/~knotinfo/diagrams/${crossing}_$i.png"
	done
done
