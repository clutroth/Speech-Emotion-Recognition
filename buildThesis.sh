#!/bin/bash
set -e

THESIS_DIR=LATEX_dyplom
THESIS_NAME=praca_dyplomowa
make -C $THESIS_DIR clean
make -C $THESIS_DIR
rm /tmp/$THESIS_NAME*
cp $THESIS_DIR/$THESIS_NAME.pdf /tmp/$THESIS_NAME-$(date +%Y%m%d)-$(git rev-parse --short HEAD).pdf
cp $THESIS_DIR/$THESIS_NAME.pdf /tmp/


