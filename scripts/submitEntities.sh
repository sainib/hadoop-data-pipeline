#!/usr/bin/env bash

project_root="/app/hadoop-data-pipeline"
sed -i.bak "s/sandbox.hortonworks.com/$(hostname -f)/" ${project_root}/falcon/cluster/primaryCluster.xml
su - admin -c "falcon entity -submit -type cluster -file ${project_root}/falcon/cluster/primaryCluster.xml"
su - admin -c "falcon entity -submit -type feed -file ${project_root}/falcon/feeds/inputFeed.xml"
su - admin -c "falcon entity -submit -type process -file ${project_root}/falcon/process/processData.xml"

