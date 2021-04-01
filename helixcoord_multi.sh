#!bin/bash
# Script to multiply by 4 the coordinate picked in bin4 micrograph to bin 1

microDir='Group5_bin4'
outDir='Group5'

for i in ${microDir}/*.box
do

base=${i#${microDir}}
awk '{printf "%-5d %-5d %-5d %-5d %-5d\n", $1*4, $2*4, $3*4, $4*4, $5}' < $i > ${outDir}${base}

done;
