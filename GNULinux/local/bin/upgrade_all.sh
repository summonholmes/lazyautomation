#!/bin/sh
alias conda="/home/summonholmes/.local/miniconda3/bin/conda"
DEST="/home/summonholmes/.upgrade_all.log"

echo `date` > $DEST 2>&1

sleep 60

conda update --all -y >> $DEST 2>&1
conda clean --all -y >> $DEST 2>&1
sudo dnf update -y >> $DEST 2>&1
