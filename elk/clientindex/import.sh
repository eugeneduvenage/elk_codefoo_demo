#!/bin/bash

LOGFILE="../logstash/logs/$(date +%F).log"

# LOG THE START TIME
STARTTIME=$(date +%s)

shopt -s dotglob
while IFS= read -r file; do
    echo -e "Uploading $file\c"
    curl -s -X POST http://elastic.local/_bulk -H "Content-Type: application/x-ndjson" --data-binary "@$file" > /dev/null 2>&1
    echo "\"$(date +'%F %R')\",\"${file}\"" >> $LOGFILE
    echo "...done"
done < <(find ./output/*.txt)

# LOG END TIME
ENDTIME=$(date +%s)
echo "Import done in $(($ENDTIME - $STARTTIME)) seconds"