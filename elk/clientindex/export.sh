#!/bin/bash

source ./export_batch.sh

LIMIT=100000
OFFSET=0

# GET THE TOTAL NUMBER OF RECORDS TO EXPORT FROM POSTGRES
export PGPASSWORD=halopass
COUNT=$(psql -h localhost -U halo -c "SELECT COUNT(*) from public.naturalpersons" -A -t)

# LOG THE START TIME
STARTTIME=$(date +%s)

# ITERATE IN BATCHES OF LIMIT AND EXPORT TO A FILE FOR THAT BATCH (IN PARALLEL)
for i in $(seq 0 $LIMIT $COUNT)
do
    echo "Exporting records $i to $(($i + $LIMIT))"
    ( export_batch $LIMIT $i ${#COUNT}) &
    OFFSET=$(($i + $LIMIT))
done
# WAIT FOR ALL BACKGROUND PROCESSES TO COMPLETE
wait

# LOG END TIME
ENDTIME=$(date +%s)
echo "Export done in $(($ENDTIME - $STARTTIME)) seconds"