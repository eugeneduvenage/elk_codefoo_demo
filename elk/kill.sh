#!/bin/bash
docker-compose stop && docker-compose rm -f | true

rm ./logstash/logs/*.log |true