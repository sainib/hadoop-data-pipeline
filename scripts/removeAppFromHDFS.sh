#!/usr/bin/env bash

source "${__dir}/../conf"

un=`whoami`
if [ $un == 'root' ]; then
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hql/*"
#su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/pig/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/conf/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/jars/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/falcon/workflow/*"
else

echo "Unable to switch user to ${demo_user}. Run as root."

fi


