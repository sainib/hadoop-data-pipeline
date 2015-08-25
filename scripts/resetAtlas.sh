#!/bin/bash

python /usr/hdp/2.3.0.0-2557/atlas/bin/atlas_stop.py
rm -rf /var/lib/atlas/data
python /usr/hdp/2.3.0.0-2557/atlas/bin/atlas_start.py
sleep 10
python /usr/hdp/2.3.0.0-2557/atlas/bin/quick_start.py
