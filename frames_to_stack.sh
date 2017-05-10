#!/bin/bash
# Script to combine single image frames into stack
# Original frames are in MRC mode 6 (unsigned integer)
# Stack frames are in MRC mode 1 (signed integer)
# Used for EPU 1.5
# HB 2015/10/06
# Base command to combine frames in to stack
# Required IMOD installed
# newstack -mode 1 abc_frames_n*.mrc abc_movie.mrcs

inputDir='Frames'
outDir='Movies'

if [ ! -d "${outDir}" ]; then 
        mkdir ${outDir}
else
        echo "${outDir} exists !!! Continue in 2s anyway ...";
        sleep 2s
fi

for i in ${inputDir}/*n0.mrc;
do
        foo=${i/_frames_n0.mrc}
        foo=${foo#${inputDir}/}
        echo "newstack -mode 1 ${inputDir}/${foo}_frames_n*.mrc ${outDir}/${foo}_movie.mrcs";
        newstack -mode 1 ${inputDir}/${foo}_frames_n*.mrc ${outDir}/${foo}_movie.mrcs
done
