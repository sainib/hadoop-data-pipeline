#!/usr/bin/env bash

source "${__dir}/../conf"

su - ${demo_user} -c "falcon entity -schedule -type feed -name demoEventData"
su - ${demo_user} -c "falcon entity -schedule -type process -name demoEventProcess"

