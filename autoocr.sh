#!/bin/bash

POLL_INTERVAL=${POLL_INTERVAL:=10}
QUEUE_PATH=${QUEUE_PATH:="./queue"}
TARGET_PATH=${TARGET_PATH:="./out"}
LANGUAGES=${LANGUAGES:="deu"}
PDF_SANDWICH_OPTIONS=${PDF_SANDWICH_OPTIONS:="-rgb -nopreproc"}
FILE_OWNER=${FILE_OWNER:="root"}
FILE_GROUP=${FILE_GROUP:="root"}
FILE_MODE=${FILE_MODE:="660"}

terminate() {
    exit 0
}

trap terminate INT TERM TSTP

while true;
do
    find "$QUEUE_PATH" -name "*.pdf" -type f -exec ./process.sh "{}" "$TARGET_PATH" "$LANGUAGES" "$PDF_SANDWICH_OPTIONS" "$FILE_OWNER" "$FILE_GROUP" "$FILE_MODE" \;
    sleep $POLL_INTERVAL
done