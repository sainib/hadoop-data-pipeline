#!/usr/bin/env bash


# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"

source "${__dir}/../conf"

su - hdfs -c "hdfs dfs -chmod 777 /user/${demo_user}/data_pipeline_demo/data"

rm -rf /root/data_pipeline_demo/input/SV-sample*xml
cp /app/hadoop-data-pipeline/input_data/SV-sample-1.xml /root/data_pipeline_demo/input/
#cp /app/hadoop-data-pipeline/input_data/SV-sample-2.xml /root/data_pipeline_demo/input/
#cp /app/hadoop-data-pipeline/input_data/SV-sample-3.xml /root/data_pipeline_demo/input/

