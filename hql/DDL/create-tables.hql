

--add jar for the JSON Serde - path is local on the Hive Client server (NOT HDFS) 
add jar /usr/hdp/2.2.0.0-2041/hive-hcatalog/share/hcatalog/hive-hcatalog-core.jar

create database demodb;

use demodb;


--* BASE XML TABLE - FIRST TABLE TO GET LOADED - CLEANUP ALSO *-

CREATE external TABLE if not exists raw_xml
(
row string
) STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/raw_xml';


--* BASE JSON TABLE - CLEANUP ALSO *-

CREATE external TABLE if not exists raw_json
(
row string
) STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/raw_json';


--* JSON COLUMNOR TABLE - CLEANUP ALSO *-

create table sv_json_data ( 
studyid string,
domain string,
ussubjid string,
visitnum string,
visit string,
svstdtc date,
svendtc date,
groupSeq int,
groupOID string
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe' STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/sv_json_data';

--* EXPORT TABLE : CLEANUP ALSO  *-

create table sv_aggregate(
studyid string,
visit string,
year int,
month int,
visit_count int
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/sv_aggregate';

--* Archive tables *--

CREATE external TABLE if not exists xml_data_archive
(
row string
) STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/xml_data_archive';


create table sv_json_data_master ( 
studyid string,
domain string,
ussubjid string,
visitnum string,
visit string,
svstdtc date,
svendtc date,
groupSeq int,
groupOID string
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe' STORED AS TEXTFILE LOCATION '/user/ambari-qa/data_pipeline_demo/hivedb/sv_json_data_master';


