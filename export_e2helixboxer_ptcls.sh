#!/bin/bash
# Script to export particle coordinate from e2helixboxer to .box format
# NOT YET PARALLEL
# Edit the parameters in the echo & final line of the scripts
# To export data for a single micrograph
#  e2helixboxer.py micro.mrc --ptcl-length=120 --ptcl-overlap=90 --ptcl-coords=micro.txt

microDir='Micrographs'


for i in ${microDir}/*.mrc
do
        base=${i/.mrc}
        if [ -e "${base}.box" ]; then
                continue;
        fi
        echo e2helixboxer.py $i --ptcl-coords=${i/.mrc}.txt
        e2helixboxer.py $i  --ptcl-length=400 --ptcl-overlap=327 --ptcl-coords=${i/.mrc}.txt
done; 
