#!/bin/bash

function die_with {
    echo "PROVISION FAILED RUNNING: $1" >&2
    exit 1
};

trap 'LASTCMD=$this_command; this_command=$BASH_COMMAND' DEBUG
