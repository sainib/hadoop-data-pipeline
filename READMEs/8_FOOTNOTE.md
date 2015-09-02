&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/7_MONITORING.md)
## Word of Caution 

Top three things that could go wrong, when setting up a Falcon job are - 

* Permission - to submit Falcon entities, defined in Hadoop Config within Ambari console
* Permission - to read input data as the user who submitted the job
* Permission - to write the output data to the specified output directory as the user who submitted the job. 

Solution is simply to ensure all the required directories exist and that the user who submitted the Falcon entities have the right permissions on those directories. 

### How to make this demo work in a clustered environment 

TBD 


### How to make this demo work for other versions of HDP

TBD

#### Falcon Patches as of April 2015
```
Apply Falcon Patches 915 and 945 to make sure those bugs do not impact the flow. 

```
&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/7_MONITORING.md)



##TBD 
bin/atlasclient --c=importmysql --mysqlhost=mysql.hortonworks.com --password=trucker --username=trucker1 --db=test  -createHiveTables -genLineage --ambariClusterName=Sandbox --suppress