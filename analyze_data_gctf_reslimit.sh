#!/bin/bash
# Script to analyze the distribution of res_limit of data and plot

inputDir='Micrographs'

rm res_limit_all.txt

res_3=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 3) print $7}' | wc -l )

if [ $res_3='' ]; then
        res_3=0;
fi

res_4=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 4) print $7}' | wc -l )
res_5=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 5) print $7}' | wc -l )
res_6=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 6) print $7}' | wc -l )
res_7=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 7) print $7}' | wc -l )
res_8=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 < 8) print $7}' | wc -l )
res_bad=$( grep ''RES_LIMIT'' $inputDir/*_gctf.log | awk '{if ($7 >= 8) print $7}' | wc -l )

let res_8=$res_8-$res_7
let res_7=$res_7-$res_6
let res_6=$res_6-$res_5
let res_5=$res_5-$res_4
let res_4=$res_4-$res_3

echo "0 \" < 3A\" $res_3" > res_limit_all.txt
echo "1 \"3-4A\" $res_4" >> res_limit_all.txt
echo "2 \"4-5A\" $res_5" >> res_limit_all.txt
echo "3 \"5-6A\" $res_6" >> res_limit_all.txt
echo "4 \"6-7A\" $res_7" >> res_limit_all.txt
echo "5 \"7-8A\" $res_8" >> res_limit_all.txt
echo "6 \"worse than 8A\"  $res_bad" >> res_limit_all.txt

rm plot_res_limit.plt
echo "set style fill solid" > plot_res_limit.plt
echo set xlabel \"Resolution Limit\" >> plot_res_limit.plt
echo set ylabel \"No. of Micrographs\" >> plot_res_limit.plt
echo set tics font \",10\" >> plot_res_limit.plt
echo set key off >> plot_res_limit.plt
echo set title \"Data distribution by RES_LIMIT from Gctf\" >> plot_res_limit.plt
echo "plot 'res_limit_all.txt' using 1:3:xtic(2) with boxes" >> plot_res_limit.plt
echo set term png >> plot_res_limit.plt
echo set output \"res_limit.png\" >> plot_res_limit.plt
echo replot >> plot_res_limit.plt
echo set term x11 >> plot_res_limit.plt

gnuplot < plot_res_limit.plt
