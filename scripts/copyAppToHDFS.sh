#!/bin/bash

set +vx 

un=`whoami`
project_root="/app/hadoop-demos/data-pipeline/flow1"
if [ $un == 'root' ]; then

su - ambari-qa -c "hdfs dfs -put ${project_root}/hql/* /user/ambari-qa/data_pipeline_demo/hql/"
echo "Copied HQL files to HDFS"
su - ambari-qa -c "hdfs dfs -put ${project_root}/udf/target/* /user/ambari-qa/data_pipeline_demo/jars/"
echo "Copied UDF jar files to HDFS"
su - ambari-qa -c "hdfs dfs -put /usr/hdp/2.2.0.0-2041/hive-hcatalog/share/hcatalog/hive-hcatalog-core.jar /user/ambari-qa/data_pipeline_demo/jars/"
echo "Copied Serde jar files to HDFS"
su - ambari-qa -c "hdfs dfs -put ${project_root}/jars/* /user/ambari-qa/data_pipeline_demo/jars/"
echo "Copied other jar files to HDFS"
su - ambari-qa -c "hdfs dfs -put ${project_root}/falcon/workflow/* /user/ambari-qa/data_pipeline_demo/falcon/workflow/"
echo "Copied Falcon workflow files to HDFS"
su - ambari-qa -c "hdfs dfs -put /etc/hive/conf/hive-site.xml /user/ambari-qa/data_pipeline_demo/conf"
echo "Copied conf files to HDFS"

else

echo "Unable to switch user to ambari-qa. Run as root."

fi


