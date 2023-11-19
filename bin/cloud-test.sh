#!/bin/bash

RESULTS="./"
      if [ ! -z "$FILE_PATH" ]; then
         RESULTS="${FILE_PATH}-"
      fi


PAYLOAD="{\"name\": \"Joris Conijn\"}"
FUNCTION_NAME=$(./bin/get-function-name.sh)
RESULTS=$RESULTS${FUNCTION_NAME}"-run-results.json"
aws lambda invoke \
         --function-name ${FUNCTION_NAME} \
         --cli-binary-format raw-in-base64-out \
         --payload "${PAYLOAD}" \
         "${RESULTS}"
