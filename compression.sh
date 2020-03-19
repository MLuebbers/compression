#!/bin/bash

a=`pwd`
i=0
processing-java --sketch=$a --output=$a/output --force --run "create" $i $2
while [ $i -lt $1 ]
do
    echo $i 
    python3 compression.py noise $i bmp
    ((i++))
    processing-java --sketch=$a --output=$a/output --force --run "restructure" $i $2
done
i=0
while [ $i -lt $1 ]
do
    echo $i 
    python3 makeBad.py noise $i
    ((i++))
done
say Your toast is finished