#!/bin/bash
# Script to run motioncor2 using GPU for all the stack
# Base Command for MotionCor2 correction for Falcon 2 movie
# MotionCor2 -InMrc Micrographs/ABC_movie.mrcs -OutMrc Micrographs/ABC.mrc -LogFile Micrographs/ABC_MotionCor2.log -Patch 5 5 -LogFile ${outDir}/${foo}_MotionCor2.log -StackZ 7 -FmDose 2.3 -InitDose 3.5 -PixSize 1.395 -kV 300 
# Stuff to change
# FmDose = dose per each bin, normally 50% less than the real dose
# initDose = dose that included in the frames thrown out in collection
# PixelSize

inputDir='Frames'
outDir='Micrographs'
gpuNo=2

if [ ! -d "$outDir" ]; then
        mkdir $outDir
else
        echo "${outDir} exists. Continue in 2s anyway ..!"
        sleep 2s;
fi

count=0

for i in ${inputDir}/*_frames.mrc;
do
        foo=${i#${inputDir}/}
        foo=${foo/_frames.mrc}
        if [ ! -e "${outDir}/${foo}.mrc" ]; then 
                #echo ${count}
                #echo MotionCor2 -InMrc ${i} -OutMrc ${outDir}/${foo}.mrc -Patch 5 5 -LogFile ${outDir}/${foo}_MotionCor2.log -StackZ 7 -FmDose 2.3 -InitDose 3.5 -PixSize 1.395 -kV 300 -Gpu ${count} &

                MotionCor2 -InMrc ${i} -OutMrc ${outDir}/${foo}.mrc -Patch 5 5 -LogFile ${outDir}/${foo}_MotionCor2.log -StackZ 7 -FmDose 2.3 -InitDose 3.5 -PixSize 1.395 -kV 300 -Gpu $count &
                let count=$count+1        
                if [ "$count" -eq "$gpuNo" ]; then
                        wait
                        count=0
                fi

        else
                echo "Skip ${foo}"
        fi
done
