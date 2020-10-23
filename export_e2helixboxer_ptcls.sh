#!/bin/bash
# Script to export particle coordinate from e2helixboxer to .box format
# NOT YET PARALLEL
# To export data for a single micrograph
#  e2helixboxer.py micro.mrc --ptcl-coords=micro.txt

microDir='Micrographs'


for i in ${microDir}/*.mrc
do
        base=${i/.mrc}
        if [ -e "${base}.box" ]; then
                continue;
        fi
        echo e2helixboxer.py $i --ptcl-coords=${i/.mrc}.txt
        e2helixboxer.py $i --ptcl-coords=${i/.mrc}.txt
done; 
