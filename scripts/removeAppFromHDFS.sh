#!/usr/bin/env bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"

un=`whoami`
if [ $un == 'root' ]; then

./suspendEntites.sh
./deleteEntities.sh

echo "Creating Hive Tables - Start"
su - ${demo_user} -c "hive -f ${project_root}/hql/DDL/drop-database.hql"
echo "Creating Hive Tables - Done"


su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/hql/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/conf/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/jars/*"
su - ${demo_user} -c "hdfs dfs -rm -r /user/${demo_user}/data_pipeline_demo/falcon/workflow/*"


echo "Removing HDFS project directory - Start"
su - hdfs -c "hdfs dfs -rm -f -R /user/${demo_user}/data_pipeline_demo"
echo "Removing HDFS project directory - End"

su - hdfs -c "hdfs dfs -rm -f -R /apps/falcon/primaryCluster"
rm -rf /root/data_pipeline_demo


echo "Rolling back flume - Start"
mv /etc/flume/conf/flume.conf.bak /etc/flume/conf/flume.conf 
echo "Rolling back flume - Done"


echo "Dropping MYSQL Table - Start"
echo "****Assuming MySQL Database is installed****"
mysql -u root < ${project_root}/sql/droptbl.sql
echo "Dropping MYSQL Table - Done"




else

echo "Unable to switch user to ${demo_user}. Run as root."

fi


