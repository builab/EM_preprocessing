#!/bin/bash
# Script to do create ctffind4 files for all micrographs
# 2016/07/22 Update with MotionCor2

inputDir='Micrographs_MotionCorr'

# Temporary move the DW from MotionCor2
mkdir ${inputDir}/DW
mv ${inputDir}/*DW.mrc ${inputDir}/DW

# Voltage (kV)
vol=300
# Amplitude Contrast (0-1)
amp=0.07
# Spherical Aberation (mm)
cs=2.7
# Pixel size
pixelsize=1.395
# Tile size
tilesize=512
# Defocus
maxdef=50000
mindef=7000
step=500
# Res range
resmax=5
resmin=30
astig=100
# CTFFIND4
ctfbin='/mnt/data0/software/ctffind4'

for i in ${inputDir}/*.mrc;
do
 base=${i/.mrc}
 outFile=${base}_ctffind4.com
 # Check if the ctffind4  is already run for this micrograph
 if [ -e "${base}_ctffind4.log" ]; then
        #rm $outFile
        #echo "Skip ${base}"  
        continue;
 fi
 # Write the file
 echo "#!/usr/bin/env csh" > $outFile
 echo "${ctfbin} > ${base}_ctffind4.log << EOF" >> ${outFile}
 echo $i >> $outFile
 echo ${base}.ctf >> $outFile
 echo $pixelsize >> $outFile
 echo $vol >> $outFile
 echo $cs >> $outFile
 echo $amp >> $outFile
 echo $tilesize >> $outFile
 echo $resmin >> $outFile
 echo $resmax >> $outFile
 echo $mindef >> $outFile
 echo $maxdef >> $outFile
 echo $step >> $outFile
 echo $astig >> $outFile
 echo "no" >> $outFile
 echo EOF >> $outFile
 
 # Give run permisson
 chmod +x $outFile
done

# Now running the scripts
for i in ${inputDir}/*ctffind4.com
do
 base=${i/.com}
 if [ -e "${base}.log" ]; then
        #rm $outFile
        echo "Skip ${base}"  
        continue;
 fi
 ./${i}
done
 
# move the temporary file back
mv ${inputDir}/DW/*DW.mrc ${inputDir}
