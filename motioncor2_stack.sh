#!/bin/bash
# Script to run motioncor2 using GPU for all the stack
# 2016/07/11
# Base Command for MotionCor2 correction for Falcon 2
# HB 2016/05/19 Resume the motion correction when the script is stopped in the middle
# This skip file based on log file

inputDir='Movies'
outDir='Micrographs'

if [ ! -d "$outDir" ]; then
        mkdir $outDir
else
        echo "${outDir} exists. Continue in 2s anyway ..!"
        sleep 2s;
fi

for i in ${inputDir}/*_movie.mrcs;
do
        #echo $i
        foo=${i#${inputDir}/}
        foo=${foo/_movie.mrcs}
        if [ ! -e "${outDir}/${foo}.mrc" ]; then 
                echo MotionCor2 -InMrc ${i} -OutMrc ${outDir}/${foo}.mrc -Patch 5 5 -LogFile ${outDir}/${foo}_MotionCor2.log -StackZ 7 -FmDose 2.3 -PixSize 1.395 -kV 300 -Gpu 0
                MotionCor2 -InMrc ${i} -OutMrc ${outDir}/${foo}.mrc -Patch 5 5 -LogFile ${outDir}/${foo}_MotionCor2.log -StackZ 7 -FmDose 2.3 -PixSize 1.395 -kV 300 -Gpu 0
        else
                echo "Skip ${foo}"
        fi
done;
