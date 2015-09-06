#!/usr/bin/env bash

un=`whoami`
if [ $un == 'root' ]; then
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/hql/*"
#su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/pig/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/conf/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/jars/*"
su - admin -c "hdfs dfs -rm -r /user/admin/data_pipeline_demo/falcon/workflow/*"
else

echo "Unable to switch user to admin. Run as root."

fi


