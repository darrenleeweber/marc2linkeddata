#!/usr/bin/env bash

# See loc_downloads.sh to get the data
# This script assumes the data are ntriples in *.nt files.

# Check that a 4store KB is available and running.  This
# script assumes that the KB is called 'loc'.
4s-admin list-stores | grep -q -E 'loc.*available.*running'
if [ $? -eq 0 ]; then
    echo "4store KB 'loc' is available and running."
    files=$(find ./ -name '*.nt')
    for f in ${files}; do
        filesize=$(du -h "$f" | cut -f1)
        echo "$filesize" | grep -q -F 'G'
        if [ $? -eq 0 ]; then
            echo "Running 4s-import for $f ($filesize); this could take some time ..."
        else
            echo "Running 4s-import for $f ($filesize)"
        fi
        # Usage: 4s-import <kbname> <rdf file/URI> ...
        4s-import -f ntriples loc $f
    done
fi

