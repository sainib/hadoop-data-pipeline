#!/bin/bash
set +vx
service ntpd start
chkconfig ntpd on

echo "Changing Feed File"

project_root="/app/hadoop-demos/data-pipeline/flow1"
cd ${project_root}/falcon/feeds
rm -rf inputFeed.xml.ORIGINAL
cp inputFeed.xml inputFeed.xml.ORIGINAL

vl=`grep -n "validity" inputFeed.xml.ORIGINAL | awk -F':' '{ print $1 }'`
vlb=$(( $vl - 1 ))
vla=$(( $vl + 1 ))

ve=$(date -d "+10 days" +"%Y-%m-%dT%H:%MZ")
vs=$(date -d "+1 minutes" +"%Y-%m-%dT%H:%MZ")

head -n $vlb inputFeed.xml.ORIGINAL  >> inputFeed.xml.new
echo "<validity start=\"${vs}\" end=\"${ve}\" />" >> inputFeed.xml.new
tail -n +$vla  inputFeed.xml.ORIGINAL >> inputFeed.xml.new

rm inputFeed.xml
mv inputFeed.xml.new inputFeed.xml

echo "Changed Feed File"
cd -