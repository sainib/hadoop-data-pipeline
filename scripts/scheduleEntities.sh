#!/usr/bin/env bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}/../conf"

su - ${demo_user} -c "falcon entity -schedule -type feed -name demoEventData"
su - ${demo_user} -c "falcon entity -schedule -type process -name demoEventProcess"

