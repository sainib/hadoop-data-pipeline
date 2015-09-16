#!/usr/bin/env bash

source "${__dir}/../conf"

su - ${demo_user} -c "falcon entity -suspend -type feed -name demoEventData"
su - ${demo_user} -c "falcon entity -suspend -type process -name demoEventProcess"
