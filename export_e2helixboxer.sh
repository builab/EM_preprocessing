#!/bin/bash
# Script to export helix coordinate from e2helixboxer to .box format
# To export data for a single micrograph
#  e2helixboxer.py micro.mrc --helix-coords=micro_helix.box

microDir='Micrographs'


for i in ${microDir}/*.mrc
do
        base=${i/.mrc}
        if [ -e "${base}_helix.box" ]; then
                continue;
        fi
        echo e2helixboxer.py $i --helix-coords=${i/.mrc}_helix.box
        e2helixboxer.py $i --helix-coords=${i/.mrc}_helix.box
done; 

