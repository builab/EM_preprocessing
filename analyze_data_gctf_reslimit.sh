#!/bin/bash
# Script to analyze the res_limit of data from gctf and plot
# HB 2017/07/25 modified to 0.5 bin

inputDir='gctf'

rm res_limit_all.txt

res_30=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 3) print $7}' | wc -l )

if [ $res_30='' ]; then
	res_30=0;
fi

res_35=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 3.5) print $7}' | wc -l )
res_40=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 4.0) print $7}' | wc -l )
res_45=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 4.5) print $7}' | wc -l )
res_50=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 5.0) print $7}' | wc -l )
res_55=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 5.5) print $7}' | wc -l )
res_60=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 6.0) print $7}' | wc -l )
res_65=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 6.5) print $7}' | wc -l )
res_70=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 7.0) print $7}' | wc -l )
res_80=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 8.0) print $7}' | wc -l )
res_bad=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 >= 8.0) print $7}' | wc -l )

let res_80=$res_80-$res_70
let res_70=$res_70-$res_65
let res_65=$res_65-$res_60
let res_60=$res_60-$res_55
let res_55=$res_55-$res_50
let res_50=$res_50-$res_45
let res_45=$res_45-$res_40
let res_40=$res_40-$res_35
let res_35=$res_35-$res_30

echo "0 \"   <3.0A\" $res_30" > res_limit_all.txt
echo "1 \"3.0-3.5A\" $res_35" >> res_limit_all.txt
echo "2 \"3.5-4.0A\" $res_40" >> res_limit_all.txt
echo "3 \"4.0-4.5A\" $res_45" >> res_limit_all.txt
echo "4 \"4.5-5.0A\" $res_50" >> res_limit_all.txt
echo "5 \"5.0-5.5A\" $res_55" >> res_limit_all.txt
echo "6 \"5.5-6.0A\" $res_60" >> res_limit_all.txt
echo "7 \"6.0-6.5A\" $res_65" >> res_limit_all.txt
echo "8 \"6.5-7.0A\" $res_70" >> res_limit_all.txt
echo "9 \"7.0-8.0A\" $res_80" >> res_limit_all.txt
echo "10 \"  >8.0A\" $res_bad" >> res_limit_all.txt

rm plot_res_limit.plt
echo "set style fill solid" > plot_res_limit.plt
echo set xlabel \"Resolution Limit\" >> plot_res_limit.plt
echo set ylabel \"No. of Micrographs\" >> plot_res_limit.plt
echo set tics font \",6\" >> plot_res_limit.plt
echo set key off >> plot_res_limit.plt
echo set title \"Data distribution by RES_LIMIT from Gctf\" >> plot_res_limit.plt
echo "plot 'res_limit_all.txt' using 1:3:xtic(2) with boxes" >> plot_res_limit.plt
echo " " >> plot_res_limit.plt
echo set term png >> plot_res_limit.plt
echo set output \"res_limit.png\" >> plot_res_limit.plt
echo replot >> plot_res_limit.plt
echo set term x11 >> plot_res_limit.plt

gnuplot < plot_res_limit.plt
