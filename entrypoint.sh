#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start the gunicorn web server
# Render sets the PORT env variable dynamically. If it is not set, we default to 8000.
PORT="${PORT:-8000}"
echo "Starting Gunicorn server on port $PORT..."
exec gunicorn variety.wsgi:application --bind 0.0.0.0:$PORT
