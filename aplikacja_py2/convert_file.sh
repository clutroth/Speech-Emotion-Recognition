#!/bin/bash
set -e
file="/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/ZD/MGR_ZD_T.wav"


cp $file unstandarized.wav
./normalize.py unstandarized.wav unstandarized.dat standarized.dat

gnuplot draw_audio_signal_plot.gp
