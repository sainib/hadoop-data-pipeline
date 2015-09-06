create database default;
use default;

CREATE external TABLE if not exists raw_xml
(
myrow string
) STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/raw_xml';

CREATE external TABLE if not exists raw_json
(
myrow string
) STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/raw_json';

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
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe' STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/sv_json_data';

create table sv_aggregate(
studyid string,
visit string,
year int,
month int,
visit_count int
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/sv_aggregate';

CREATE external TABLE if not exists xml_data_archive
(
myrow string
) STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/xml_data_archive';

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
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe' STORED AS TEXTFILE LOCATION '/user/admin/data_pipeline_demo/hivedb/sv_json_data_master';
