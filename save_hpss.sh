iif [ -f "`hostname`.h5" ]; then
    echo "`hostname`.h5 exist" # Record in database
    hsi cput `hostname`.h5 : testing/`hostname`.h5
else 
    echo "`hostname`.h5 does not exist"
fi