#!/bin/bash

# tells the bash script to exit whenever anything returns a non-zero return value.
set -e

./bin/wait-for-postgres.sh

rails db:version || bundle exec rails db:setup
rails db:migrate

bundle exec foreman start
