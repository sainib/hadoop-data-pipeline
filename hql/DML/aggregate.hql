USE ${hivevar:hive_db};
--set hive.execution.engine=tez;
add jar hdfs://${hivevar:workflow_root_dir}/jars/hive-hcatalog-core.jar;

--********** QUERY NUMBER 1 : Move data from XML table to JSON table ************---

insert overwrite table ${hivevar:json_raw_table}
select convertJArr2Obj(convertX2J(row)) from ${hivevar:xml_raw_table};

--********** QUERY NUMBER 2 : Move JSON Data into next table that uses JSON Serde ************---

LOAD DATA INPATH '${hivevar:workflow_root_dir}/hivedb/${hivevar:json_raw_table}/' OVERWRITE INTO TABLE ${hivevar:json_events_table};

--********** QUERY NUMBER 3 : Aggregate the data for export ************---

insert overwrite table ${hivevar:export_table}
select studyid,visit,year(svstdtc),month(svstdtc),count(*) from ${hivevar:json_events_table}
group by 
studyid,visit,year(svstdtc),month(svstdtc)
;

--********** QUERY NUMBER 4 : Copy the xml data into archive table  ************---

insert into table ${hivevar:xml_archive_table}
select * from ${hivevar:xml_raw_table};

--********** QUERY NUMBER 5 : Aggregate the data for export ************---

insert into table ${hivevar:json_events_master_table}
select * from ${hivevar:json_events_table};
