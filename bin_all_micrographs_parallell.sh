# Script to bin images for picking
# HB 2019/12/16

inputDir='Movies' # Input micrograph folder
outDir='Movies_bin4' # Output micrograph folder
noproc=4 # Number of parallel process
bin=4 # bin factor, default = 4

if [ ! -d "${outDir}" ]; then 
        mkdir ${outDir}
else
        echo "${outDir} exists !!! Continue in 2s anyway ...";
        sleep 2s
fi

rm zz

for i in ${inputDir}/*.mrc;
do
        foo=${i#${inputDir}/}
        echo "newstack -bin $bin $i ${outDir}/${foo}" >> zz
        #newstack -bin 4 $i ${outDir}/${foo}
done

parallel --jobs $noproc < zz

rm zz 
