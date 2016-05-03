#!/usr/bin/env bash
set +vx
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"
project_root="/app/hadoop-data-pipeline"


#sed -i.bak "s/DATA_PIPELINE_DEMO_HOST/$(hostname -f)/" ${project_root}/falcon/cluster/primaryCluster.xml.SRC
sed -e "s/DATA_PIPELINE_DEMO_HOST/$(hostname -f)/" ${project_root}/falcon/cluster/primaryCluster.xml.SRC > ${project_root}/falcon/cluster/primaryCluster.xml
su - ${demo_user} -c "falcon entity -submit -type cluster -file ${project_root}/falcon/cluster/primaryCluster.xml"


sed -e "s/DATA_PIPELINE_DEMO_USER/${demo_user}/" ${project_root}/falcon/feeds/inputFeed.xml.SRC > ${project_root}/falcon/feeds/inputFeed.xml
. ./changeValidityForFeed.sh
su - ${demo_user} -c "falcon entity -submit -type feed -file ${project_root}/falcon/feeds/inputFeed.xml"



sed -e "s/DATA_PIPELINE_DEMO_USER/${demo_user}/" ${project_root}/falcon/process/processData.xml.SRC > ${project_root}/falcon/process/processData.xml
. ./changeValidityForProcess.sh
su - ${demo_user} -c "falcon entity -submit -type process -file ${project_root}/falcon/process/processData.xml"

