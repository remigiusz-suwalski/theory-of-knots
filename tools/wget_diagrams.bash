#!/bin/bash
diagrams=([3]="1" [4]="1" [5]="2" [6]="3" [7]="7" [8]="21" [9]="49" [10]="165")
virtuals=([0]="1" [2]="1" [3]="7" [4]="108")

for crossing in "${!diagrams[@]}"; do
    for ((i=1;i<=${diagrams[$crossing]};i++)); do
    	wget --wait=10 --random-wait \
            "http://www.indiana.edu/~knotinfo/diagrams/${crossing}_$i.png"
	done
done

for crossing in "${!virtuals[@]}"; do
    for ((i=1;i<=${virtuals[$crossing]};i++)); do
    	wget \
			--wait=10 \
			--random-wait \
			-O "virtual_${crossing}_$i.png" \
			"http://www.math.toronto.edu/drorbn/Students/GreenJ/images/${crossing}.$i.png"

	done
done

