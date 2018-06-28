#!/bin/bash

export_batch() {
    LIMIT=$1
    OFFSET=$2

    #
    # CREATE A FILENAME FOR THE BATCH IN THE FORMAT OF - data_STARTOFBATCH_ENDOFBATCH.txt 
    # e.g. data_00000000_01000000.txt
    #
    FILELEN=$3
    FILENAME_START=$(printf "%0*d" $FILELEN $OFFSET)
    FILENAME_END=$(printf "%0*d" $FILELEN $(($OFFSET + $LIMIT)))
    BULKFILE="output/data_${FILENAME_START}_${FILENAME_END}.txt"
    if [ -f "$BULKFILE" ]
    then
        rm "$BULKFILE"
    fi

    # GET THE BATCH OF RECORDS FROM THE REST API
    DATA=$(curl -s "http://api.local/naturalpersons?limit=$LIMIT&offset=$OFFSET&order=id.asc")

    # FOR EACH JSON RECORD CREATE A BULK UPLOAD RECORD
    ID=$OFFSET
    while IFS= read -r line;
    do
        echo -e "{ \"index\" : { \"_index\" : \"client\", \"_type\" : \"client\", \"_id\": $ID }}\n$line"
        ID=$(($ID + 1))
    done< <( jq -r -c '.[]' <<<"$DATA")>>$BULKFILE
}