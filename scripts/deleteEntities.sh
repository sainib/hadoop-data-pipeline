#!/usr/bin/env bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"

su - ${demo_user} -c "falcon entity -delete -type process -name demoEventProcess"
su - ${demo_user} -c "falcon entity -delete -type feed -name demoEventData"
su - ${demo_user} -c "falcon entity -delete -type cluster -name primaryCluster"
