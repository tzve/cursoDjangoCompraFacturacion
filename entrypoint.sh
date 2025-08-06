#!/bin/bash
set -e

echo "Entorno: $ENVIRONMENT"

if [ "$ENVIRONMENT" = "DEV" ]; then
  echo "Iniciando en modo DEV"
  exec python manage.py runserver 0.0.0.0:8000
else
  echo "Iniciando en modo  $ENVIRONMENT"
  exec gunicorn core.wsgi:application --bind 0.0.0.0:8000
fi