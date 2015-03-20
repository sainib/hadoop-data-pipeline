#!/bin/bash

un=`whoami`
if [ $un == 'root' ]; then
su - ambari-qa -c "hdfs dfs -rm -r /user/ambari-qa/data_pipeline_demo/hql/*"
#su - ambari-qa -c "hdfs dfs -rm -r /user/ambari-qa/data_pipeline_demo/pig/*"
su - ambari-qa -c "hdfs dfs -rm -r /user/ambari-qa/data_pipeline_demo/conf/*"
su - ambari-qa -c "hdfs dfs -rm -r /user/ambari-qa/data_pipeline_demo/jars/*"
su - ambari-qa -c "hdfs dfs -rm -r /user/ambari-qa/data_pipeline_demo/falcon/workflow/*"
else

echo "Unable to switch user to ambari-qa. Run as root."

fi


