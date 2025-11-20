#!/bin/bash

LOG_GROUP="/devops/intern-metrics"
LOG_STREAM="ec2-metrics"
LOG_FILE="/var/log/system_report.log"

TOKEN=$(aws logs describe-log-streams \
  --log-group-name $LOG_GROUP \
  --log-stream-name $LOG_STREAM \
  --query 'logStreams[0].uploadSequenceToken' \
  --output text)

aws logs put-log-events \
  --log-group-name $LOG_GROUP \
  --log-stream-name $LOG_STREAM \
  --log-events "[{\"timestamp\":$(date +%s000),\"message\":$(tail -n 17 $LOG_FILE | jq -Rs .)}]" \
  --sequence-token $TOKEN
