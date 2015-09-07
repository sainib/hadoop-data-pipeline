#!/usr/bin/env bash


su - hdfs -c "hdfs dfs -chmod 777 /user/admin/data_pipeline_demo/data"

rm -rf /root/data_pipeline_demo/input/SV-sample*xml
cp /app/hadoop-data-pipeline/input_data/SV-sample-1.xml /root/data_pipeline_demo/input/
#cp /app/hadoop-data-pipeline/input_data/SV-sample-2.xml /root/data_pipeline_demo/input/
#cp /app/hadoop-data-pipeline/input_data/SV-sample-3.xml /root/data_pipeline_demo/input/

