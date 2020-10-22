#!/bin/bash
# SCript to convert mrc to png (binning twice)
# Using bin doesn't make scaling very attractive

inputDir='Movies_bin4_sel'
outDir='Movies_bin4_sel_png'


if [ ! -d "${outDir}" ]; then 
        mkdir ${outDir}
else
        echo "${outDir} exists !!! Continue in 2s anyway ...";
        sleep 2s
fi


for i in ${inputDir}/*.mrc;
do
        foo=${i#${inputDir}/}
	foo=${foo/.mrc}
        echo "e2proc2d.py $i ${outDir}/${foo}.png --fixintscaling sane";
       e2proc2d.py $i ${outDir}/${foo}.png --fixintscaling sane
done
