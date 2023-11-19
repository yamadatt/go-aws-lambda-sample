#!/bin/bash

SELF_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

STACK_NAME=$(basename $(pwd))

FUNCTION_NAME=$(aws cloudformation list-exports | 
    jq -r '.Exports[] | "\(.Name) \(.Value)"' | 
    grep  "$STACK_NAME" | 
    awk 'BEGIN{FS=" "}{print $2}')
if [[ $? -eq 0  ]]; then
    echo "$FUNCTION_NAME"
    exit 0
else
    exit 1
fi
