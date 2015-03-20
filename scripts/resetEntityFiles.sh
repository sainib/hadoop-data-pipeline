#!/bin/bash
set +vx 
rm -rf ../falcon/feeds/*
git checkout ../falcon/feeds/inputFeed.xml

rm -rf ../falcon/process/*a.xml*
git checkout ../falcon/process/processData.xml

