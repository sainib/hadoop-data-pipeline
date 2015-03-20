#!/bin/bash

su - ambari-qa -c "falcon entity -delete -type process -name demoEventProcess"
su - ambari-qa -c "falcon entity -delete -type feed -name demoEventData"
su - ambari-qa -c "falcon entity -delete -type cluster -name primaryCluster"
