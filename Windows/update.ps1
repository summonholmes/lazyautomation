$DEST="C:\Users\summonholmes\Scripts\update.log"
sleep 60
Get-Date > $DEST 2>&1
conda update --all -y >> $DEST 2>&1
conda clean --all -y >> $DEST 2>&1
choco upgrade all -y >> $DEST 2>&1
