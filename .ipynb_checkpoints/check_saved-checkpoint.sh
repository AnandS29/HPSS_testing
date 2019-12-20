hsi
cd testing # doesn't work - figure out how to go to hsi and go to folder or how to check if file exists in hsi
if [ -f "`hostname`.h5" ]; then
    # check size of file
    echo "`hostname`.h5 was saved"
else 
    echo "`hostname`.h5 was not saved"
fi