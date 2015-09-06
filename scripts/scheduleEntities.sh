#!/usr/bin/env bash

su - admin -c "falcon entity -schedule -type feed -name demoEventData"
su - admin -c "falcon entity -schedule -type process -name demoEventProcess"

