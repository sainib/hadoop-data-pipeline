#!/bin/bash


su - ambari-qa -c "falcon entity -submit -type cluster -file /app/hadoop-demos/data-pipeline/flow1/falcon/cluster/primaryCluster.xml"
su - ambari-qa -c "falcon entity -submit -type feed -file /app/hadoop-demos/data-pipeline/flow1/falcon/feeds/inputFeed.xml"
su - ambari-qa -c "falcon entity -submit -type process -file /app/hadoop-demos/data-pipeline/flow1/falcon/process/processData.xml"

