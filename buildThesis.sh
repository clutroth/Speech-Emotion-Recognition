#!/bin/bash
set -e

THESIS_DIR=LATEX_dyplom
THESIS_NAME=praca_dyplomowa

cd $THESIS_DIR
pdflatex $THESIS_NAME.tex
cp $THESIS_NAME.pdf /tmp/


