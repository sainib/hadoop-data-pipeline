#!/bin/bash


bash suspendEntites.sh 
bash deleteEntities.sh 
bash demoReset.sh 
su - ambari-qa -c "hive -f ${project_root}/hql/DDL/drop-database.hql"

su - atlas -c "/usr/hdp/2.3.0.0-2557/atlas/bin/atlas_stop.py"
rm -rf /var/lib/atlas/data
su - atlas -c "/usr/hdp/2.3.0.0-2557/atlas/bin/atlas_start.py"
sleep 10
su - atlas -c "/usr/hdp/2.3.0.0-2557/atlas/bin/quick_start.py"

echo "Create hivedb  File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/hivedb"
echo "Create hivedb  File  directory - Done"

su - ambari-qa -c "hive -f /app/hadoop-data-pipeline/hql/DDL/create-tables-nocomments.hql"
su - ambari-qa -c "hive -f /app/hadoop-data-pipeline/hql/DDL/create-udfs.hql"
su - ambari-qa -c "hive -f /app/hadoop-data-pipeline/hql/DDL/add-json-serde.hql"


bash changeValidityForFeed.sh 
bash changeValidityForProcess.sh 
bash submitEntities.sh 
bash scheduleEntities.sh 

