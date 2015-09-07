#!/usr/bin/env bash

project_root="/app/hadoop-data-pipeline"

un=`whoami`
if [ $un == 'root' ]; then

echo "Cleaning up data directory"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/data/process/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/data/backup/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/data/input/*"
echo "Cleaned up data directory"

echo "Cleaning up hive table - start"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/raw_xml/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/raw_json/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/sv_aggregate/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/sv_json_data/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/sv_json_data_master/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hivedb/xml_data_archive/*"
echo "Cleaning up hive table - done"

echo "Cleaning up mysql table - start"
mysql < ${project_root}/sql/truncatetbl.sql
echo "Cleaning up mysql table - done"

echo "Cleaning up Flume directory - Start"
rm -f /root/data_pipeline_demo/input/*
echo "Cleaning up Flume directory - Done"

else

echo "Unable to switch user to admin. Run as root."

fi


