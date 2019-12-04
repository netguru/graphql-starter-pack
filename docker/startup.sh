#! /bin/sh

./docker/prepare-db.sh
echo 'Here I am'
mkdir -p ./tmp/pids
bundle exec puma -C config/puma.rb
