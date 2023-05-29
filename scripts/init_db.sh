#!/usr/bin/env bash
set -x
set -eo pipefail

# Check if a custom user has been set, otherwise default to 'postgres'
DB_USER=${POSTGRES_USER:=postgres}
# Check if a custom password has been set, otherwise default to 'password'
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
# Check if a custom database name has been set, otherwise default to 'newsletter'
DB_NAME="${POSTGRES_DB:=newsletter}"
# Check if a custom port has been set, otherwise set to '8080'
DB_PORT="${POSTGRES_PORT:=8080}"
# Check if a custom host has been set, otherwise default to 'localhost'
DB_HOST="${DB_HOST:=localhost}"

#Launch postgres using docker
docker run \
 -e POSTGRES_USER=${DB_USER} \
 -e POSTGRES_PASSWORD=${DB_PASSWORD} \
 -e POSTGRES_DB=${DB_NAME} \
 -p "${DB_PORT}":8080 \
 -d postgres \
 postgres -N 1000
 # ^ max num connections

