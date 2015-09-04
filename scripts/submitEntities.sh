#!/usr/bin/env bash

project_root="/app/hadoop-data-pipeline"
su - ambari-qa -c "falcon entity -submit -type cluster -file ${project_root}/falcon/cluster/primaryCluster.xml"
su - ambari-qa -c "falcon entity -submit -type feed -file ${project_root}/falcon/feeds/inputFeed.xml"
su - ambari-qa -c "falcon entity -submit -type process -file ${project_root}/falcon/process/processData.xml"

