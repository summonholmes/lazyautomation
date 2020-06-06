#!/bin/sh
# Create aliases or else this won't work
alias conda="/Users/shanekimble/.local/miniconda3/bin/conda"
alias brew="/usr/local/bin/brew"

# Set ENV variables
DEST="/Users/shanekimble/.update.log"

# Timestamp
echo `date` > $DEST 2>&1

# Give time for services and connection to settle
sleep 60

# Update miniconda environment
conda update --all -y >> $DEST 2>&1
conda clean --all -y >> $DEST 2>&1

# Update all installed packages
brew upgrade >> $DEST 2>&1
brew cask upgrade >> $DEST 2>&1
