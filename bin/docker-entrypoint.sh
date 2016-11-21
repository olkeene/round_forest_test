#!/bin/bash

bundle check || bundle install --jobs 4 --retry 5

rm tmp/pids/server.pid

./bin/wait-for-postgres.sh

echo "Running in app: $@"
exec "$@"
