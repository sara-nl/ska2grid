#!/bin/bash

# obtain information for the Worker Node
echo `date`
echo ${HOSTNAME}
echo ${HOME}
echo ${PWD}

# run the application
#cat /etc/centos-release
#ls /cvmfs/softdrive.nl/lofar_sw/
sendmail [add your email HERE] < email.txt

# copy the output to the Grid storage 
globus-url-copy -vb gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/skatelescope.eu/disk/natalie_test/testfile file:///`pwd`/test_natalie
time globus-url-copy -vb gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/skatelescope.eu/disk/natalie_test/openstack_test_datasetX.tgz file:///`pwd`/openstack_test_datasetX.tgz

if [[ "$?" != "0" ]]; then
    echo "Problem copying files from dCache. Exiting now..."
    exit 1
fi

cat test_natalie
globus-url-copy -vb file:///`pwd`/test_natalie gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/skatelescope.eu/disk/natalie_test/testfileX

# list final files and exit
ls -allh ${PWD}
exit 0
