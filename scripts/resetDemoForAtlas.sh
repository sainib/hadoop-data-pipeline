#!/bin/bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"

bash suspendEntites.sh 
bash deleteEntities.sh 
bash demoReset.sh 
su - ${demo_user} -c "hive -f ${project_root}/hql/DDL/drop-database.hql"

su - atlas -c "/usr/hdp/current/atlas-server/bin/atlas_stop.py"
rm -rf /var/lib/atlas/data
su - atlas -c "/usr/hdp/current/atlas-server/bin/atlas_start.py"
sleep 10
su - atlas -c "/usr/hdp/current/atlas-server/bin/quick_start.py"

echo "Create hivedb  File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/${demo_user}/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chmod 777 /user/${demo_user}/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chown ${demo_user}:hadoop /user/${demo_user}/data_pipeline_demo/hivedb"
echo "Create hivedb  File  directory - Done"

su - ${demo_user} -c "hive -f /app/hadoop-data-pipeline/hql/DDL/create-tables-nocomments.hql"
su - ${demo_user} -c "hive -f /app/hadoop-data-pipeline/hql/DDL/create-udfs.hql"
su - ${demo_user} -c "hive -f /app/hadoop-data-pipeline/hql/DDL/add-json-serde.hql"


bash changeValidityForFeed.sh 
bash changeValidityForProcess.sh 
bash submitEntities.sh 
bash scheduleEntities.sh 

