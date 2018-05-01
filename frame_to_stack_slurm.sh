#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=cpusmall
#SBATCH --error=error.log
#SBATCH --output=frames_to_stack.log
#SBATCH --job-name=frames_to_stack
#SBATCH --mem 1000


# Script to combine single image frames into stack
# Used for EPU 1.5
# HB 2018/04/30
# Base command to combine frames in to stack
# newstack -mode 1  abc_frames_n*.mrc abc_movie.mrcs
# Rot 90 degree to backward compatible

module load imod

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
	echo "newstack -rotate -90 ${inputDir}/${foo}_frames_n*.mrc ${outDir}/${foo}_frames.mrcs";
	newstack -rotate -90 ${inputDir}/${foo}_frames_n*.mrc ${outDir}/${foo}_frames.mrcs
done
