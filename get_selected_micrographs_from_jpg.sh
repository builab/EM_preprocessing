# Copy all the micrographs with the jpg exists in the jpg_clean folder to new folder
# HB 2015/10/06
jpegdir='jpg_comb'
microdir='Micrographs_Orig'

if [ ! -d "${microdir}" ]; then
  mkdir ${microdir}
else
  echo "Directory Micrographs already exists ..."
  sleep 2s
fi


for i in ${jpegdir}/*; 
do 
 foo=${i#${jpegdir}/};
 foo=${foo/.jpg};
 echo "mv Grid*/Data/${foo}* ${microdir}";
 mv Grid*/Data/${foo}* ${microdir}
done
