#!/bin/bash
POSTGRES_DATABASE_URL=postgres://root:password@postgres:5432/root

if [ -f /.dockerenv ]; then
  # only do this stuff if running in Docker
  until psql $POSTGRES_DATABASE_URL -c "select 1" > /dev/null 2>&1; do
    echo "Waiting for Postgres server to start up..."
    sleep 1
  done

  if [ "$( psql $POSTGRES_DATABASE_URL -tAc "SELECT 1 FROM pg_database WHERE datname='django_boilerplate'" )" != '1' ];
  then
    echo "Database does not exist, creating 'django_boilerplate'"
    psql $POSTGRES_DATABASE_URL -c 'CREATE DATABASE django_boilerplate'
    python manage.py migrate
  fi
fi

while true; do
  echo "Starting development server"
  echo "Running Django with watchdog"
  watchmedo auto-restart -d . -p'*.py' --recursive -- python manage.py runserver 0.0.0.0:8000 --noreload
  echo "Server exited with code $?.. restarting in a few seconds..."
  sleep 1
done
