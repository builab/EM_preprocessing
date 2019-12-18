#!/bin/bash
# Script to bin images for picking
# HB 2019/12/16

inputDir='Movies'
outDir='Movies_bin4'

if [ ! -d "${outDir}" ]; then 
        mkdir ${outDir}
else
        echo "${outDir} exists !!! Continue in 2s anyway ...";
        sleep 2s
fi


for i in ${inputDir}/*.mrc;
do
        foo=${i#${inputDir}/}
        echo "newstack -bin 4 $i ${outDir}/${foo}";
        newstack -bin 4 $i ${outDir}/${foo}
done
