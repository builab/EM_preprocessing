#!/bin/bash
# Script to run gctf for all micrographs in a folder after MotionCor2
# Temporary move all the dose weighted in a folder
# 2016/07/22

inputDir='Micrographs'

mkdir ${inputDir}/DW
mv ${inputDir}/*DW.mrc ${inputDir}/DW

gctf --apix 1.395 --kV 300 --Cs 2.7 --ac 0.1 --do_EPA --defL 5000 --defH 50000 --defS 100 --resL 30 --resH 5 --boxsize 512 ${inputDir}/*.mrc

mv ${inputDir}/DW/*.mrc ${inputDir}
