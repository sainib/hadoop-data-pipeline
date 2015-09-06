#!/usr/bin/env bash

set +vx 

un=`whoami`
project_root="/app/hadoop-data-pipeline"
hdp_version="$(hdp-select status hadoop-client | awk '{print $3}')"
if [ $un == 'root' ]; then

su - admin -c "hdfs dfs -put ${project_root}/hql/* /user/admin/data_pipeline_demo/hql/"
echo "Copied HQL files to HDFS"
su - admin -c "hdfs dfs -put ${project_root}/udf/target/* /user/admin/data_pipeline_demo/jars/"
echo "Copied UDF jar files to HDFS"
su - admin -c "hdfs dfs -put /usr/hdp/current/hive-webhcat/share/hcatalog/hive-hcatalog-core.jar /user/admin/data_pipeline_demo/jars/"
echo "Copied Serde jar files to HDFS"
su - admin -c "hdfs dfs -put ${project_root}/jars/* /user/admin/data_pipeline_demo/jars/"
echo "Copied other jar files to HDFS"
su - admin -c "hdfs dfs -put ${project_root}/falcon/workflow/* /user/admin/data_pipeline_demo/falcon/workflow/"
echo "Copied Falcon workflow files to HDFS"
su - admin -c "hdfs dfs -put /etc/hive/conf/hive-site.xml /user/admin/data_pipeline_demo/conf"
echo "Copied conf files to HDFS"

else

echo "Unable to switch user to admin. Run as root."

fi


