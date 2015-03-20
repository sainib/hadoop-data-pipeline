#!/bin/bash

su - ambari-qa -c "falcon entity -suspend -type feed -name demoEventData"
su - ambari-qa -c "falcon entity -suspend -type process -name demoEventProcess"
