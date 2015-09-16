#!/usr/bin/env bash

project_root="/app/hadoop-data-pipeline"
source "${__dir}/../conf"

un=`whoami`
if [ $un == 'root' ]; then

echo "Cleaning up data directory"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/data/process/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/data/backup/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/data/input/*"
echo "Cleaned up data directory"

echo "Cleaning up hive table - start"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/raw_xml/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/raw_json/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/sv_aggregate/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/sv_json_data/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/sv_json_data_master/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hivedb/xml_data_archive/*"
echo "Cleaning up hive table - done"

echo "Cleaning up mysql table - start"
mysql < ${project_root}/sql/truncatetbl.sql
echo "Cleaning up mysql table - done"

echo "Cleaning up Flume directory - Start"
rm -f /root/data_pipeline_demo/input/*
echo "Cleaning up Flume directory - Done"

else

echo "Unable to switch user to ${demo_user}. Run as root."

fi


