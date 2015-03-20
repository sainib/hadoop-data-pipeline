#Custom UDFs to handle certain XML / JSON transformations 

At this time, there are 2 UDFs in this code repository 
* For converting XML into JSON
* For converting a JSON Array to a JSON Object (VERY SPECIFIC TO THE FORMAT USED IN EXAMPLE BELOW)

The java code for converting XML into JSON is generic and is included in this code repo. 

NOTE: The second UDF is very specific to the format of the XML used in this example and should be changed to either handle any JSON Array generically or to match the specific format you are using. 

Follow the steps below to add these custom UDFs to Hive Server on your cluster

* Get the code from github
```
git clone <git repo url>
```

* Compile the UDF code 
```
cd ./hadoop-demos/data-pipeline/udf
bash build.sh
```

* Copy the jar file to a directory on HDFS. (Assuming the selected directory is /user/ambari-qa/
```
cd target
hdfs dfs -put MyXml2JsonUdf.jar /user/ambari-qa
hdfs dfs -chmod 755 /user/ambari-qa/MyXml2JsonUdf.jar
```

* Create a User Defined Function from the Java code in the jar file. 
```

Using command line, type hive

hive:> use demodb; 

hive:> CREATE FUNCTION convertX2J AS 'XML2JSONConvertor' USING JAR 'hdfs:///user/ambari-qa/data_pipeline_demo/jars/MyXml2JsonUdf.jar';

hive:> CREATE FUNCTION convertJArr2Obj AS 'JSONObjector' USING JAR 'hdfs:///user/ambari-qa/data_pipeline_demo/jars/MyXml2JsonUdf.jar';

```

* Test the UDF
```
create table xmlTest ( col1 string ) ; 

insert into table xmlTest values ('<ItemGroupData data:ItemGroupDataSeq="1" ItemGroupOID="DM"><ItemData ItemOID="DM.STUDYID" Value="CDISCPILOT01"/><ItemData ItemOID="DM.DOMAIN" Value="DM"/><ItemData ItemOID="DM.USUBJID" Value="01-701-1015"/><ItemData ItemOID="DM.SUBJID" Value="1015"/><ItemData ItemOID="DM.RFSTDTC" Value="2014-01-02"/><ItemData ItemOID="DM.RFENDTC" Value="2014-07-02"/><ItemData ItemOID="DM.RFXSTDTC" Value="2014-01-02"/><ItemData ItemOID="DM.RFXENDTC" Value="2014-07-02"/><ItemData ItemOID="DM.RFPENDTC" Value="2014-07-02T11:45"/><ItemData ItemOID="DM.SITEID" Value="701"/><ItemData ItemOID="DM.AGE" Value="63"/><ItemData ItemOID="DM.AGEU" Value="YEARS"/><ItemData ItemOID="DM.SEX" Value="F"/><ItemData ItemOID="DM.RACE" Value="WHITE"/><ItemData ItemOID="DM.ETHNIC" Value="HISPANIC OR LATINO"/><ItemData ItemOID="DM.ARMCD" Value="Pbo"/><ItemData ItemOID="DM.ARM" Value="Placebo"/><ItemData ItemOID="DM.ACTARMCD" Value="Pbo"/><ItemData ItemOID="DM.ACTARM" Value="Placebo"/><ItemData ItemOID="DM.COUNTRY" Value="USA"/><ItemData ItemOID="DM.DMDTC" Value="2013-12-26"/><ItemData ItemOID="DM.DMDY" Value="-7"/><ItemData ItemOID="DM.COMPLT16" Value="Y"/><ItemData ItemOID="DM.COMPLT24" Value="Y"/><ItemData ItemOID="DM.COMPLT8" Value="Y"/><ItemData ItemOID="DM.EFFICACY" Value="Y"/><ItemData ItemOID="DM.ITT" Value="Y"/><ItemData ItemOID="DM.SAFETY" Value="Y"/></ItemGroupData>');

select convertX2J(col1) from xmlTest;

#The inner JSON Array will be changed to JSON Object with this.. 
select convertJArr2Obj(convertX2J(*)) from xmltest;

```