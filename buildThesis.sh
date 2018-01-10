#!/bin/bash
set -e

THESIS_DIR=LATEX_dyplom
THESIS_NAME=praca_dyplomowa
make -C $THESIS_DIR
cp $THESIS_DIR/$THESIS_NAME.pdf /tmp/


