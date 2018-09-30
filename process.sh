#!/bin/bash

INPUT_FILE="$1"
OUTPUT_PATH="$2"
LANGUAGES="$3"
PDF_SANDWICH_OPTIONS="$4"
FILENAME=$(basename "$INPUT_FILE")
OUTPUT_FILE="$OUTPUT_PATH/$FILENAME"

echo "Processing $INPUT_FILE into $OUTPUT_FILE..."

PROCESS_FILE="$OUTPUT_FILE.processing"
TRACE_FILE="$OUTPUT_FILE.trace"
mv "$INPUT_FILE" "$PROCESS_FILE" 

pdfsandwich -o "$OUTPUT_FILE" -lang "$LANGUAGES" $PDF_SANDWICH_OPTIONS "$PROCESS_FILE" &> "$TRACE_FILE"
PDF_SANDWICH_PID=$!

wait $PDF_SANDWICH_PID
EC=$?

if [ $EC == 0 ]
then
    rm "$TRACE_FILE"
    rm "$PROCESS_FILE"
    echo "Sucessfully processed $INPUT_FILE"
    exit 0
fi

FAILED_FILE="$OUTPUT_FILE.failed"
mv "$PROCESS_FILE" "$FAILED_FILE"
echo "ERROR: pdfsandwich failed to process $INPUT_FILE with exit code $EC. See the following trace for details:"
cat "$TRACE_FILE"
exit 1