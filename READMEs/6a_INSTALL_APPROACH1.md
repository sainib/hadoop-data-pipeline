&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/5_INSTALL_OPTIONS.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/7_MONITORING.md)
# Installation Approach 1 - Step by Step

## Steps to setup up Demo

### Checkout the code 
```
mkdir /app
cd /app
git clone https://github.com/sainib/hadoop-data-pipeline.git
```


### HDFS
* Setup HDFS Directories (hql, workflow, jars, scripts)
* From the Hadoop Gateway / Edge / Client or Master server 
 ```
 su - hdfs 

 #hql File Directories 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/hql
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/hql
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/hql

 #pig File Directories 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/jars
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/jars
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/jars
 
 #conf File Directories 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/conf
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/conf
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/conf
 
 #Data File Directories 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/input
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/input
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/input
 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/process
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/process
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/process

hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/data/backup
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/data/backup
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/data/backup

#Falcon working directories 
hdfs dfs -mkdir -p /apps/falcon/primaryCluster/staging
hdfs dfs -chmod 777 /apps/falcon/primaryCluster/staging
hdfs dfs -chown falcon:hadoop /apps/falcon/primaryCluster/staging

hdfs dfs -mkdir -p /apps/falcon/primaryCluster/working
hdfs dfs -chmod 755 /apps/falcon/primaryCluster/working
hdfs dfs -chown falcon:hadoop /apps/falcon/primaryCluster/working

 #falcon workflow File Directories 
hdfs dfs -mkdir -p /user/ambari-qa/data_pipeline_demo/falcon/workflow
hdfs dfs -chmod 777 /user/ambari-qa/data_pipeline_demo/falcon/workflow
hdfs dfs -chown ambari-qa:hadoop /user/ambari-qa/data_pipeline_demo/falcon/workflow
```
* Copy the required files to HDFS
```
su - ambari-qa
hdfs dfs -put /app/hadoop-data-pipeline/hql/* /user/ambari-qa/data_pipeline_demo/hql/

hdfs dfs -put /app/hadoop-data-pipeline/jars/* /user/ambari-qa/data_pipeline_demo/jars/

hdfs dfs -put /etc/hive/conf/hive-site.xml /user/ambari-qa/data_pipeline_demo/conf

hdfs dfs -put /app/hadoop-data-pipeline/udf/target/* /user/ambari-qa/data_pipeline_demo/jars/
hdfs dfs -put /usr/hdp/2.2.0.0-2041/hive-hcatalog/share/hcatalog/hive-hcatalog-core.jar /user/ambari-qa/data_pipeline_demo/jars/

hdfs dfs -put /app/hadoop-data-pipeline/falcon/workflow/* /user/ambari-qa/data_pipeline_demo/falcon/workflow/
```


#### Hive
* Setup Hive (tables, udfs, jars)
Note: The user who will be submitting Falcon jobs needs to have write permissions to these tables. So, run this command, to create Hive tables, either with the user who will be submitting Falcon jobs or another user within the same group, ensuring that Hive tables have write permission for the group.

```
su - ambari-qa
hive -f /app/hadoop-data-pipeline/hql/DDL/create-tables.hql
```

* Add JSON Serde Jar to Hive
```
bash:>su - ambari-qa

bash:>hive

hive:> use demodb; 

hive:> add jar hdfs:///user/ambari-qa/data_pipeline_demo/jars/hive-hcatalog-core.jar;
```

* Create a User Defined Function from the Java code in the jar file. 
```

bash:>su - ambari-qa

bash:>hive

hive:> use demodb; 

hive:> CREATE FUNCTION convertX2J AS 'XML2JSONConvertor' USING JAR 'hdfs:///user/ambari-qa/data_pipeline_demo/jars/MyXml2JsonUdf.jar';

hive:> CREATE FUNCTION convertJArr2Obj AS 'JSONObjector' USING JAR 'hdfs:///user/ambari-qa/data_pipeline_demo/jars/MyXml2JsonUdf.jar';

```

Follow the README.MD within the ./udf directory for more details.


#### Flume
* Use these instructions to setup the flume part of the project using spooling directory flume configurations. See [Flume Spooling Dir Docs](https://flume.apache.org/FlumeUserGuide.html#spooling-directory-source)
```
 - On gateway server 
 - mkdir -p /root/data_pipeline_demo/input
 - cd 
 - cd /etc/flume/conf
 - mv flume.conf flume.conf.bak
 - cd - 
 - cp ./flume.conf /etc/flume/conf/flume.conf

```

#### Sqoop
```
Upload RDBMS JDBC Connector jar to /usr/share/java/
cd /usr/lib/hadoop/
ln -s /usr/share/java/<jar-name>.jar
cd /usr/hdp/2.2.0.0-2041/sqoop/lib
ln -s /usr/share/java/<jar-name>.jar
```

Important Note / Caution : 

```
* Select the right user ids - avoid using master users for the services for setting up your process. like - hdfs, hue, falcon, etc. The correct approach is to establish a process id (unix id on the cluster that does not belong to a person but is used for running jobs) and assign proper permissions to that user id so that you can interact with different services using those service ids. Also, typically this process id shares group with the IT / Dev/ Support group so that work done by process is visible to the appropriate parties. 

* Ensure file / directory permissions - See the note at the end of the document but in short, make sure the user used for running the process has all the required rights on the directories involved to finish the job. 
```

#### SQL

```

Create the external RDBMS table using the ddl.sql in ./sql/

```

This is it from setup standpoint. 


### STARTING the demo process

* Start Flume on the edge node - 
```
cd /var/log/flume
nohup flume-ng agent -c /etc/flume/conf -f /etc/flume/conf/flume.conf -n sandbox & 

```


* Submitting and Scheduling the Falcon jobs

```
falcon entity -submit -type cluster -file /app/hadoop-data-pipeline/falcon/cluster/primaryCluster.xml
falcon entity -submit -type feed -file /app/hadoop-data-pipeline/falcon/feeds/inputFeed.xml
falcon entity -submit -type process -file /app/hadoop-data-pipeline/falcon/process/processData.xml
falcon entity -schedule -type feed -name demoEventData
falcon entity -schedule -type process -name demoEventProcess
```

Note - 

* Verify the properties in /app/hadoop-data-pipeline/falcon/process/processData.xml (within the properties block)
* The validity in /app/hadoop-data-pipeline/falcon/feeds/inputFeed.xml and /app/hadoop-data-pipeline/falcon/process/processData.xml should be in UTC timezone. Also, adjust the frequency as needed & set the validity time to the current time (or as needed). 

### Supplying the input data 

* Copy the sample data provided in ./input_data/ to the flume spool directory
```
cp /app/hadoop-data-pipeline/input_data/SV-sample-1.xml /root/data_pipeline_demo/input
```


### To stop the processing 
```
falcon entity -suspend -type feed -name demoEventData
falcon entity -suspend -type process -name demoEventProcess

falcon entity -delete -type process -name demoEventProcess
falcon entity -delete -type feed -name demoEventData
falcon entity -delete -type cluster -name primaryCluster

```


&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/5_INSTALL_OPTIONS.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/7_MONITORING.md)