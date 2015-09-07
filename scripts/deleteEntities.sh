#!/usr/bin/env bash

su - admin -c "falcon entity -delete -type process -name demoEventProcess"
su - admin -c "falcon entity -delete -type feed -name demoEventData"
su - admin -c "falcon entity -delete -type cluster -name primaryCluster"
