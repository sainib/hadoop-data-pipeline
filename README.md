# Flow

## Introduction

The goal of this data pipeline flow is to ingest data files, that are copied to the landing zone on a gateway server, and then process them at a regular interval. When the workflow begins, the files are ingested, stored, transformed and the transformed data is sqooped out of cluster into a MySQL database. 

In this flow, there are following processes and steps 

* Gateway Server
	* has the flume agent running with a Spooling Directory configuration, to transfer the data files to HDFS
	
* Master Server 
	* has the Falcon job running to do the following	
		* Clear the temp tables
		* Make a copy of the incoming data for backup purpose. 
		* Insert the raw data in a temp table
		* Covert the XML data into JSON and insert into another table 
		* Apply aggregation / transformation process to the JSON table 
		* Also insert the data from process (temp table) into the history table.
		* export the data out of Hive to a Mysql table
		
## Architecture

![Data Pipeline Flow 1 - Architecture](https://raw.githubusercontent.com/sainib/hadoop-demos/master/data-pipeline/flow1/architecture.png)		

## Setting up the project	

Pre-requisite - Download and install [Hortonworks Sandbox](http://www.hortonworks.com/sandbox)

```
IMPORTANT NOTE : 

This demo assumes that the automated process will be running as user - ambari-qa. 
So, it is necessary to make sure that file and directory permissions are adjusted appropriately, if you plan on using another user. 
```

* Get the source code ( git clone <repo-url> ) on sandbox VM. This demo assumes that the code is checked out in /app
* Install the demo
* Configure it 
* Run it 

```
Note: There are two ways to install and configure. 
	1. Follow the step by step instructions to install it  ( if you want to learn the nitty gritty of this demo ) 
	2. Use the scripts in hadoop-demos/data-pipeline/flow1/scripts directory ( if you want to set it up quickly ) 
```

## Installation Approach 1 - Step by Step

### Undrstanding Demo code

* This demo uses a number of components, for which the code is present in the same directory - 

	* Flume - flume configuration file 
	* Hql - hive query scripts (ddl and dml) 
	* Udf - user defined functions code for converting XML to JSON
	* Jars(Sqoop) - mysql jdbc driver 
	* Falcon - falcon entities files 
	* Sql - external RDBMS (mysql) scripts (ddl) 
	* Input data - sample input data 


### Steps to setup up Demo

#### Ambari
* Make sure that following component are running 
	- Hive
	- Falcon
	- Oozie
	- Flume

* Ambari Config / Setting
```
// Save and restart all components after changing configs

// Hive, set
webhcat.proxyuser.oozie.groups = *
webhcat.proxyuser.oozie.hosts = *

// hdfs - core site
hadoop.proxyuser.oozie.groups = *
hadoop.proxyuser.oozie.hosts = *

hadoop.proxyuser.falcon.groups = *
hadoop.proxyuser.falcon.hosts = *

// Oozie
oozie.service.AuthorizationService.security.enabled = false

```

#### HDFS
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
hdfs dfs -put /app/hadoop-demos/data-pipeline/flow1/hql/* /user/ambari-qa/data_pipeline_demo/hql/

hdfs dfs -put /app/hadoop-demos/data-pipeline/flow1/jars/* /user/ambari-qa/data_pipeline_demo/jars/

hdfs dfs -put /etc/hive/conf/hive-site.xml /user/ambari-qa/data_pipeline_demo/conf

hdfs dfs -put /app/hadoop-demos/data-pipeline/flow1/udf/target/* /user/ambari-qa/data_pipeline_demo/jars/
hdfs dfs -put /usr/hdp/2.2.0.0-2041/hive-hcatalog/share/hcatalog/hive-hcatalog-core.jar /user/ambari-qa/data_pipeline_demo/jars/

hdfs dfs -put /app/hadoop-demos/data-pipeline/flow1/falcon/workflow/* /user/ambari-qa/data_pipeline_demo/falcon/workflow/
```


#### Hive
* Setup Hive (tables, udfs, jars)
Note: The user who will be submitting Falcon jobs needs to have write permissions to these tables. So, run this command, to create Hive tables, either with the user who will be submitting Falcon jobs or another user within the same group, ensuring that Hive tables have write permission for the group.

```
su - ambari-qa
hive -e /app/hadoop-demos/data-pipeline/flow1/hql/DDL/create-tables.hql
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
* Use these instructions to setup  the flume part of the project using spooling directory flume configurations. See [Flume Spooling Dir Docs](https://flume.apache.org/FlumeUserGuide.html#spooling-directory-source)
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
falcon entity -submit -type cluster -file /app/hadoop-demos/data-pipeline/flow1/falcon/cluster/primaryCluster.xml
falcon entity -submit -type feed -file /app/hadoop-demos/data-pipeline/flow1/falcon/feeds/inputFeed.xml
falcon entity -submit -type process -file /app/hadoop-demos/data-pipeline/flow1/falcon/process/processData.xml
falcon entity -schedule -type feed -name demoEventData
falcon entity -schedule -type process -name demoEventProcess
```

Note - 

* Verify the properties in /app/hadoop-demos/data-pipeline/flow1/falcon/process/processData.xml (within the properties block)
* The validity in /app/hadoop-demos/data-pipeline/flow1/falcon/feeds/inputFeed.xml and /app/hadoop-demos/data-pipeline/flow1/falcon/process/processData.xml should be in UTC timezone. Also, adjust the frequency as needed & set the validity time to the current time (or as needed). 

### Supplying the input data 

* Copy the sample data provided in ./input_data/ to the flume spool directory
```
cp /app/hadoop-demos/data-pipeline/flow1/input_data/SV-sample-1.xml /root/data_pipeline_demo/input
```


### To stop the processing 
```
falcon entity -suspend -type feed -name demoEventData
falcon entity -suspend -type process -name demoEventProcess

falcon entity -delete -type process -name demoEventProcess
falcon entity -delete -type feed -name demoEventData
falcon entity -delete -type cluster -name primaryCluster

```


## Installation Approach 2 - Using scripts

* Setup the demo.  Run these commands as root. 
```

cd /app/hadoop-demos/data-pipeline/flow1/scripts

bash setupAppOnHDFS.sh
bash changeValidityForFeed.sh 
bash changeValidityForProcess.sh 
bash copyAppToHDFS.sh 

bash submitEntities.sh
bash scheduleEntities.sh
 
 ```

* To stop the processing 
```
cd /app/hadoop-demos/data-pipeline/flow1/scripts
bash suspendEntites.sh
bash deleteEntities.sh
```


### Tracking the execution of Falcon Jobs

* Via Falcon UI 

* Via Oozie UI 

* Via YARN / JOB History UI


## Word of Caution 

Top three things that could go wrong, when setting up a Falcon job are - 

* Permission - to submit Falcon entities, defined in Hadoop Config within Ambari console
* Permission - to read input data as the user who submitted the job
* Permission - to write the output data to the specified output directory as the user who submitted the job. 

Solution is simply to ensure all the required directories exist and that the user who submitted the Falcon entities have the right permissions on those directories. 

