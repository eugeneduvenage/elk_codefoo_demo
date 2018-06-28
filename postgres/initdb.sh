#!/bin/bash 
export PGPASSWORD=halopass
psql -v ON_ERROR_STOP=1 -h localhost -U postgres postgres -f ./db/dump.sql