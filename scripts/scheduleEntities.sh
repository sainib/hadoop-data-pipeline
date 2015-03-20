#!/bin/bash

su - ambari-qa -c "falcon entity -schedule -type feed -name demoEventData"
su - ambari-qa -c "falcon entity -schedule -type process -name demoEventProcess"

