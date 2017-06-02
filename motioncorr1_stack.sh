#!/bin/bash
# Script to run motioncorr using GPU for all the stack
# 2015/10/07
# Base Command for Motion correction
# dosefgpu_driftcorr abc_movie.mrcs -bft 200 -pbx 36 -ssc 0 -nss 0 -nes 6 -fcs abc_SumCorr.mrc -flg abc_motioncorr.log 
# HB 2016/05/19 Skip the one with log file, resume the motion correction when the script is stopped in the middle

inputDir='Micrographs'
outDir='Micrographs_MotionCorr'
first=0 # First frame for averaging
last=6 # Last frame for averaging

if [ ! -d "$outDir" ]; then
        mkdir $outDir
else
        echo "${outDir} exists. Continue in 2s anyway ..!"
        sleep 2s;
fi

for i in ${inputDir}/*_movie.mrcs;
do
        echo $i
        foo=${i#${inputDir}/}
        foo=${foo/_movie.mrcs}
        if [ ! -e "${outDir}/${foo}.mrc" ]; then 
                echo dosefgpu_driftcorr $i -bft 200 -pbx 36 -ssc 0 -nss ${first} -nes ${last} -fcs ${outDir}/${foo}.mrc -flg ${outDir}/${foo}_motioncorr.log
                dosefgpu_driftcorr $i -bft 200 -pbx 36  -nss ${first} -nes ${last} -fcs ${outDir}/${foo}.mrc -flg ${outDir}/${foo}_motioncorr.log
        else
                echo "Skip ${foo}"
        fi
done;

