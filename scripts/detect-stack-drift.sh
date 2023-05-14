#!/bin/bash

USAGE='USAGE: ./detect-stack-drift.sh <STACK_NAME> <STACK_DRIFT_DETECTION_ID?>'
STACK_NAME=${1?$USAGE}
STACK_DRIFT_DETECTION_ID=${2}

if [ -z "$STACK_DRIFT_DETECTION_ID" ]; then
  STACK_DRIFT_DETECTION_ID=$(aws cloudformation detect-stack-drift \
    --stack-name $STACK_NAME \
    --profile root \
    | jq -r '.StackDriftDetectionId')
fi

echo "STACK_DRIFT_DETECTION_ID=$STACK_DRIFT_DETECTION_ID"

DETECTION_STATUS='DETECTION_IN_PROGRESS'

while [ $DETECTION_STATUS == 'DETECTION_IN_PROGRESS' ]; do
  echo 'detection in progress...'
  sleep 2
  RESULT=$(aws cloudformation describe-stack-drift-detection-status \
    --stack-drift-detection-id $STACK_DRIFT_DETECTION_ID \
    --profile root)
  DETECTION_STATUS=$(echo $RESULT | jq -r '.DetectionStatus')
  STACK_DRIFT_STATUS=$(echo $RESULT | jq -r '.StackDriftStatus')
done

printf "\nstack drift detection status:\n"
echo "$RESULT"

if [ $STACK_DRIFT_STATUS == 'DRIFTED' ]; then
  printf "\ndrifted resources:\n"
  aws cloudformation describe-stack-resource-drifts \
    --stack-name $STACK_NAME \
    --profile root \
    --output json \
    | jq -r '.StackResourceDrifts[] | select(.StackResourceDriftStatus != "IN_SYNC")'
fi
