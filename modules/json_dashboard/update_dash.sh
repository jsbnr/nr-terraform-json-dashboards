#!/bin/bash

# This script is called by the terraform module


# Check we have the necessary info to continue
if [ "$NEWRELIC_API_KEY" = "" ]; then
  echo "New Relic API key is missing, expected in env var NEWRELIC_API_KEY"
  exit 1
fi

if [ "$1" = "" ]; then
  echo "Dashboard ID must be supplied"
  exit 1
fi

if [ "$2" = "" ]; then
  echo "No data for dashboard provided"
  exit 1
fi


shopt -s extglob                                # enable better regex support
DATA=`echo "$2" | base64 -D`                    #decode the base64 data
DATA=${DATA/\"id\": +([0-9]),/"\"id\": $1,"}    #ensure the dashboard id is correct in case template is wrong
DATA=${DATA//\"widget_id\": +([0-9]),/""}       #remove widget_id attributes

curl -sS -X PUT "https://api.newrelic.com/v2/dashboards/$1.json" \
     -H "X-Api-Key:$NEWRELIC_API_KEY" \
     -H 'Content-Type: application/json' \
     -d "$DATA" > /dev/null

if [ $? -eq 0 ]
then
  echo "Successfully updated dashboard $1"
  exit 0
else
  echo "Dashboard updated failed."
  exit 1
fi