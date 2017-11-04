#!/bin/bash
set -e

THESIS_DIR=LATEX_dyplom
THESIS_NAME=praca_dyplomowa

cd $THESIS_DIR
pdflatex $THESIS_NAME
bibtex $THESIS_NAME
pdflatex $THESIS_NAME
cp $THESIS_NAME.pdf /tmp/


