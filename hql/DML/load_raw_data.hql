USE ${hivevar:hive_db};
LOAD DATA INPATH '${hivevar:workflow_root_dir}/data/process/${hivevar:execution_id}/*.input' OVERWRITE INTO TABLE ${hivevar:xml_raw_table} ;
