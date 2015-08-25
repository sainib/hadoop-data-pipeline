&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/3_ATLAS_OR_NOT.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/5_INSTALL_OPTIONS.md)
#Atlas Integration to the Falcon Demo

## Concept

The idea here is to be able to see the hive lineage of the data processing taking place in the workflow within Atlas. 

## Setup 

Before setting up the Hive tables for the falcon workflow, it is essential to ensure that Atlas is setup and is up/running to ensure that 
the table definitions are captured in Atlas before the processing starts. 

* Setup Atlas hook for Hive (See instructions below)
Make sure /etc/hive/conf/hive-site.xml has the following properties: 
```
<property>
<name>atlas.cluster.name</name>
<value>Sandbox</value>
</property>
–
<property>
<name>atlas.rest.address</name>
<value>http://sandbox.hortonworks.com:21000</value>
</property>
–
<property>
<name>hive.exec.post.hooks</name>
<value>org.apache.hadoop.hive.ql.hooks.ATSHook, org.apache.atlas.hive.hook.HiveHook</value>
</property>

<property>
<name>atlas.hook.hive.synchronous</name>
<value>true</value>
</property>

```
* Ensure you are able to see Atlas UI
```
Open http://sandbox.hortonworks.com:21000/ 
```
* ONLY FOR NEW DEMO ON SANDBOX - Cleanup the Atlas sample / seed data (See instructions below) 

```
* Stop Atlas via Ambari
* Execute this command to remove the data 
rm -rf /var/lib/atlas/data
* Start Atlas via Ambari

```

&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/3_ATLAS_OR_NOT.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/5_INSTALL_OPTIONS.md)