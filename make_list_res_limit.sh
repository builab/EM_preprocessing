#!/bin/bash
# Script to parse the RES_LIMIT from micrograph
# Move micrograph > 7 in CTF estimation to a back up folder

inputList='list_microname.txt'

echo "rm list_reslimit.txt" > xx
awk '{printf ("grep \x27RES_LIMIT\x27 %s_gctf.log | awk \x27{print $7}\x27 >> list_reslimit.txt\n", $2)}' < $inputList >> xx 

sh xx



