#!/bin/bash

#
# Get a dashboard and save to file utility
#
# ./get_dash.sh id {filename}
#

if [ "$NEWRELIC_API_KEY" = "" ]; then
  echo "New Relic API key is missing, expected in env var NEWRELIC_API_KEY"
  exit 1
fi

if [ "$1" = "" ]; then
  echo "Dashboard ID must be supplied as parm 1. Parm 2 can optionally be a filename to save to."
  exit 1
fi

if [ "$2" != "" ]; then
  OUTFILE=" -o $2"
  echo "Saving dashboard to file: $2"
fi

curl -sS -X GET "https://api.newrelic.com/v2/dashboards/$1.json" \
     -H 'X-Api-Key:$NEWRELIC_API_KEY' $OUTFILE