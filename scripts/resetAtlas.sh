#!/usr/bin/env bash

python /usr/hdp/current/atlas-server/bin/atlas_stop.py
rm -rf /var/lib/atlas/data
python /usr/hdp/current/atlas-server/bin/atlas_start.py
sleep 10
python /usr/hdp/current/atlas-server/atlas/bin/quick_start.py
