#!/usr/bin/bash
# Scripts to take all the micrographs in the Micrographs folder & CTFFIND4 info to make a micrographs_ctf.star
# HB 2016/07/12
# Usage: ./make_micrographs_ctf_star_from_ctffind3.sh > micrographs_ctf.star

microDir='Micrographs'

# Printing header
echo "
data_

loop_ 
_rlnMicrographName #1 
_rlnCtfImage #2 
_rlnDefocusU #3 
_rlnDefocusV #4 
_rlnDefocusAngle #5 
_rlnVoltage #6 
_rlnSphericalAberration #7 
_rlnAmplitudeContrast #8 
_rlnMagnification #9 
_rlnDetectorPixelSize #10 
_rlnCtfFigureOfMerit #11
_rlnFinalResolution #12";

mag=101818 # For Falcon 2
vol=300
amp=0.10
cs=2.7
detPixSize=14


for i in ${microDir}/*ctffind3.log
do
        base=${i/_ctffind3.log};
        base=${base#$microDir\/}
        defu=`grep -a 'Final Value' $i | awk '{print $1}' `
        defv=`grep -a 'Final Value' $i | awk '{print $2}' `
        astig=`grep -a 'Final Value' $i | awk '{print $3}' `
        ctffom=`grep -a 'Final Value' $i | awk '{print $4}' `
        reslimit=`grep -a 'RES_LIMIT' $i | awk '{print $7}' `
        printf "%s %s %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n" ${microDir}/${base}.mrc ${microDir}/${base}.ctf:mrc $defu $defv $astig $vol $cs $amp $mag $detPixSize $ctffom $reslimit
 done;
