#!/bin/bash

# Set environment variables directly from Docker Compose
export POSTGRES_DB=${POSTGRES_DB}
export POSTGRES_USER=${POSTGRES_USER}
export POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Execute the original entrypoint script with PostgreSQL as the argument
exec docker-entrypoint.sh postgres
