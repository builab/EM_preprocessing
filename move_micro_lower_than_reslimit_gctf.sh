#!/bin/bash
# Script to parse the RES_LIMIT from micrograph
# Move micrograph with CTF RES_LIMIT > 6 in CTF estimation to a back up folder (bak)
# HB 2016

inputDir='Micrographs'

mkdir bak

grep 'RES_LIMIT' ${inputDir}/*gctf.log | sed 's/_gctf.*LIMIT//' | awk '{if ($2 > 6) printf "mv %s* bak\n", $1}' > xx

sh xx
