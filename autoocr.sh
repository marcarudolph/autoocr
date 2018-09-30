#!/bin/bash

POLL_INTERVAL=${POLL_INTERVAL:=10}
QUEUE_PATH=${QUEUE_PATH:="./queue"}
TARGET_PATH=${TARGET_PATH:="./out"}
LANGUAGES=${LANGUAGES:="deu"}
PDF_SANDWICH_OPTIONS=${PDF_SANDWICH_OPTIONS:="-rgb -nopreproc"}

terminate() {
    exit 0
}

trap terminate INT TERM TSTP

while true;
do
    find "$QUEUE_PATH" -name "*.pdf" -type f -exec ./process.sh "{}" "$TARGET_PATH" "$LANGUAGES" "$PDF_SANDWICH_OPTIONS" \;
    sleep $POLL_INTERVAL
done