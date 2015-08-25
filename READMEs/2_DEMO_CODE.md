&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/1_PREP.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/3_ATLAS_OR_NOT.md)
## Understanding Demo code

* This demo uses a number of components, for which the code is present in the demo project root directory. 

	* Flume - flume configuration file 
	* Hql - hive query scripts (ddl and dml) 
	* Udf - user defined functions code for converting XML to JSON
	* Jars(Sqoop) - mysql jdbc driver 
	* Falcon - falcon entities files 
	* Sql - external RDBMS (mysql) scripts (ddl) 
	* Input data - sample input data 
	
	
## Data Flow

The architecture diagram in the first section provides a higher level view of the processing going going on with the cluster as part of this demo. 

The diagram below shows the flow / transformation of data within Hive, which is the core ETL step in this flow. 

![Data Flow with Hive](https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/data_flow.png)

&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/prev.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/1_PREP.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<img src="https://raw.githubusercontent.com/sainib/hadoop-data-pipeline/master/READMEs/imgs/next.jpg">](https://github.com/sainib/hadoop-data-pipeline/blob/master/READMEs/3_ATLAS_OR_NOT.md)