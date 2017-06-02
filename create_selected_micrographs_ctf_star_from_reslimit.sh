#!/bin/bash
# Script to movie bad ctf micrograph from output of ctffind4
# HB 2016
# Move micrograph > 6.5 in CTF estimation to a back up folder
# Change the value in this line to set threshold res
# fitres=`cat $i | grep "Thon rings" | awk '{if ($9 > 6.5) print "bad"}' `

inputDir='Micrographs'
inputFile='micrographs_ctf.star'
outputFile='selected_micrographs_ctf.star'
resCutoff=6.5
useCtffind4=0 # 1 is use ctffind4, 0 is gctf

#bakDir='Micrographs_Bak'
#mkdir $bakDir


if [ "$useCtffind4" -gt 0 ]; then
        echo "Use ctffind4 output"
        # Get micrographs does not satisfy the resolution criteria
        grep 'Thon rings' ${inputDir}/*ctffind4.log | awk -v var="$resCutoff" '{if ($9 > var) print $0' > xx
        # Change the name  
        sed s/_ctffind4.log:Thon.*/.mrc/i < xx > yy

else
        echo "Use gctf output"
        grep 'RES_LIMIT' ${inputDir}/*gctf.log | awk -v var="$resCutoff" '{if ($7 > var) print $0}' > xx
        sed s/_gctf.log:Resolution.*/.mrc/i < xx > yy

fi

# Exclude those micrographs from  micrographs_ctf.star
grep -vwF -f yy $inputFile > $outputFile
