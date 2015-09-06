#!/usr/bin/env bash

su - admin -c "falcon entity -suspend -type feed -name demoEventData"
su - admin -c "falcon entity -suspend -type process -name demoEventProcess"
