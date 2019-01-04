# Script to plot multiple Relion FSC into 1 plot
#In the terminal
#1.375 = pixel size of map
grep -v 'angpix' Chlamy_DMT_fsc.star | awk '{if (NF > 5) print 1.375*$2, $6}'  > ChlamyDMT.dat
grep -v 'angpix' Tetra_DMT_fsc.star | awk '{if (NF > 5) print 1.375*$2, $6}'  > TetraDMT.dat
grep -v 'angpix' Tetra_DMT_class_fsc.star | awk '{if (NF > 5) print 1.375*$2, $6}'  > TetraDMT_class.dat
grep -v 'angpix' ChlamyPF_fsc.star | awk '{if (NF > 5) print 1.375*$2, $6}'  > ChlamyPF.dat
grep -v 'angpix' TetraAllPF_fsc.star | awk '{if (NF > 5) print 1.375*$2, $6}'  > TetraPF.dat


# Start GNU plot
# Plot
gnuplot

plot "ChlamyDMT.dat" using 1:2 with lines title "Chlamy DMT", \
        "TetraDMT.dat" using 1:2 with lines title "Tetra DMT", \
        "TetraDMT_class.dat" using 1:2 with lines title "Classified Tetra DMT", \
        "ChlamyPF.dat" using 1:2 with lines title "Chlamy PF", \
        "TetraPF.dat" using 1:2 with lines title "TetraPF", 0.143 title "FSC 0.143"


set xrange [0:0.5]
set yrange [0:1]

set terminal png
set output 'FSC.png'
replot

set terminal postscript eps size 6.0,4.4 enhanced color \
    font 'Helvetica,20' linewidth 6

#set terminal postscript eps enhanced color font 'Helvetica,10' linewidth 2
set output 'FSC.eps'
replot
