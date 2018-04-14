#!/usr/bin/env gnuplot
set datafile commentschars ";"

set terminal png

set output "share/standarized.png"

set ylabel "synał ustandaryzowany"
set xlabel "czas (s)"
set yrange [-10:10]
plot "standarized.dat" using 1:2 every 100 with lines lc rgbcolor "#a0a0b0" title "synał MGR_ZD_T.wav ustandaryzowany"

set output "share/unstandarized.png"
set ylabel "synał nieustandaryzowany"
set xlabel "czas (s)"
set yrange [-10000:10000]
plot "unstandarized.dat" using 1:2 every 100 with lines lc rgbcolor "#a0a0b0" title "sygnał MGR_ZD_T.wav nieustandaryzowany"
