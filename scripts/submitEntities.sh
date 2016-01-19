#!/usr/bin/env bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"

project_root="/app/hadoop-data-pipeline"
sed -i.bak "s/sandbox.hortonworks.com/$(hostname -f)/" ${project_root}/falcon/cluster/primaryCluster.xml
su - ${demo_user} -c "falcon entity -submit -type cluster -file ${project_root}/falcon/cluster/primaryCluster.xml"
sed -i.bak "s/admin/${demo_user}/" ${project_root}/falcon/feeds/inputFeed.xml
su - ${demo_user} -c "falcon entity -submit -type feed -file ${project_root}/falcon/feeds/inputFeed.xml"
sed -i.bak "s/admin/${demo_user}/" ${project_root}/falcon/process/processData.xml
su - ${demo_user} -c "falcon entity -submit -type process -file ${project_root}/falcon/process/processData.xml"

