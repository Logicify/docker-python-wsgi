#!/bin/bash

source /srv/virtenv/bin/activate

export LANG=en_US.utf8

if [ -z "${INSTALL_REQUIREMENTS+x}" ]; then
  echo "Skip installing requirements"
else
  pip install -r requirements.txt
fi

gunicorn $APP_MODULE \
    --name $APP_PROCESS_NAME \
    --bind=0.0.0.0:$APP_PORT \
    --workers=$APP_WORKERS_COUNT \
    --worker-class=eventlet
    --timeout=$TIMEOUT \
    --log-level=$APP_LOG_LEVEL \
    --log-file="-" \
    --chdir=$APPLICATION_DIR
