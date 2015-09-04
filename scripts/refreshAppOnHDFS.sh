#!/usr/bin/env bash

. ./suspendEntites.sh
. ./deleteEntities.sh

. ./removeAppFromHDFS.sh
. ./changeValidityForProcess.sh
. ./changeValidityForFeed.sh
. ./copyAppToHDFS.sh

. ./submitEntities.sh
. ./scheduleEntities.sh

