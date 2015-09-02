#!/bin/bash

set +vx 

un=`whoami`
project_root="/app/hadoop-data-pipeline"
hdp_version="2.3.0.0-2557"
if [ $un == 'root' ]; then

#Create the project root directory
echo "Create project root directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo"
echo "Create project root directory - Done"

#hql File Directories
echo "Create hql  File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/hql"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/hql"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/hql"
su - ambari-qa -c "hdfs dfs -put ${project_root}/hql/* /user/ambari-qa/data_pipeline_demo/hql/"
echo "Create hql  File  directory - Done"

#hql File Directories
echo "Create hivedb  File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/hivedb"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/hivedb"
echo "Create hivedb  File  directory - Done"
  
#conf File Directories 
echo "Create conf File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/conf"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/conf"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/conf"
su - ambari-qa -c "hdfs dfs -put /etc/hive/conf/hive-site.xml /user/ambari-qa/data_pipeline_demo/conf"
echo "Create conf File  directory - Done"
 
#jars File Directories 
echo "Create jars File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/jars"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/jars"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/jars"
su - ambari-qa -c "hdfs dfs -put /usr/hdp/${hdp_version}/hive-hcatalog/share/hcatalog/hive-hcatalog-core.jar /user/ambari-qa/data_pipeline_demo/jars/"
su - ambari-qa -c "hdfs dfs -put ${project_root}/udf/target/* /user/ambari-qa/data_pipeline_demo/jars/"
su - ambari-qa -c "hdfs dfs -put ${project_root}/jars/* /user/ambari-qa/data_pipeline_demo/jars/"
echo "Create jars File  directory - Done"
  
#Data File Directories 
echo "Create Data File  directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/input"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/input"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/input"
 
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/process"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/process"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/process"

su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/backup"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/backup"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/backup"
echo "Create Data File  directory - Done"

#Falcon working directories 
echo "Create Falcon working directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /apps/falcon/primaryCluster/staging"
su - hdfs -c "hdfs dfs -chmod 777 /apps/falcon/primaryCluster/staging"
su - hdfs -c "hdfs dfs -chown falcon:hadoop /apps/falcon/primaryCluster/staging"

su - hdfs -c "hdfs dfs -mkdir -p /apps/falcon/primaryCluster/working"
su - hdfs -c "hdfs dfs -chmod 755 /apps/falcon/primaryCluster/working"
su - hdfs -c "hdfs dfs -chown falcon:hadoop /apps/falcon/primaryCluster/working"
echo "Create Falcon working directory - Done"

#falcon workflow File Directories 
echo "Creating Falcon workflow directory - Start"
su - hdfs -c "hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/falcon/workflow"
su - hdfs -c "hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/falcon/workflow"
su - hdfs -c "hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/falcon/workflow"
su - ambari-qa -c "hdfs dfs -put ${project_root}/falcon/workflow/* /user/ambari-qa/data_pipeline_demo/falcon/workflow/"
echo "Created Falcon workflow directory - Done"

echo "Creating Hive Tables - Start"
su - ambari-qa -c "hive -f ${project_root}/hql/DDL/create-tables.hql"
echo "Creating Hive Tables - Done"

echo "Adding JSON Serde Jar - Start"
su - ambari-qa -c "hive -f ${project_root}/hql/DDL/add-json-serde.hql"
echo "Adding JSON Serde Jar - Start"

echo "Creating UDFs - Start"
su - ambari-qa -c "hive -f ${project_root}/hql/DDL/create-udfs.hql"
echo "Creating UDFs - Done"

echo "Setting up flume - Start"
mkdir -p /root/data_pipeline_demo/input
cp /etc/flume/conf/flume.conf /etc/flume/conf/flume.conf.bak
cp ${project_root}/flume/flume.conf /etc/flume/conf/flume.conf
echo "Setting up flume - Done"

echo "Setting up MYSQL JDBC driver for Sqoop - Start"
cp ${project_root}/jars/mysql-connector-java.jar /usr/share/java/
cd /usr/lib/hadoop/
ln -s /usr/share/java/mysql-connector-java.jar
cd -
cd /usr/hdp/${hdp_version}/sqoop/lib
ln -s /usr/share/java/mysql-connector-java.jar
cd - 
echo "Setting up MYSQL JDBC driver for Sqoop - Done"

echo "Setting up MYSQL Database - Start"
echo "****Assuming MySQL Database is installed****"
mysql < ${project_root}/sql/ddl.sql
echo "Setting up MYSQL Database - Done"

echo "Starting the Flume Agent - Start"
cd /var/log/flume
nohup flume-ng agent -c /etc/flume/conf -f /etc/flume/conf/flume.conf -n sandbox & 
echo ""
echo ""
echo "Starting the Flume Agent - Done"

else

echo "Error : Unable to switch user. Run as root"

fi
