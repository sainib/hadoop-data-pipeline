#Atlas Integration to the Falcon Demo

## Concept

The idea here is to be able to see the hive lineage of the data processing taking place in the workflow within Atlas. 

## Setup 

Before setting up the Hive tables for the falcon workflow, it is essential to ensure that Atlas is setup and is up/running to ensure that 
the table definitions are captured in Atlas before the processing starts. 

* Setup Atlas hook for Hive (See instructions below)
Make sure /etc/hive/conf/hive-site.xml should have the following properties: 
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
. Ensure you are able to see Atlas UI
. ONLY FOR NEW DEMO ON SANDBOX - Cleanup the Atlas sample / seed data (See instructions below) 