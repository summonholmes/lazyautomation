#!/bin/sh
alias conda="/Users/shanekimble/.local/miniconda3/bin/conda"
alias brew="/usr/local/bin/brew"
DEST="/Users/shanekimble/.update.log"
echo `date` > $DEST 2>&1
sleep 60
conda update --all -y >> $DEST 2>&1
conda clean --all -y >> $DEST 2>&1
brew upgrade >> $DEST 2>&1
brew upgrade --cask >> $DEST 2>&1
brew cleanup >> $DEST 2>&1
