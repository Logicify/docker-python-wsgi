FROM logicify/python3
MAINTAINER "Dmitry Berezovsky <dmitry.berezovsky@logicify.com>"

ENV APP_PROCESS_NAME="wsgi-application"
ENV APP_MODULE="wsgi"
ENV APP_WORKERS_COUNT="3"
ENV APP_LOG_LEVEL="info"
ENV APP_PORT="8000"
ENV LOG_DIR="/srv/logs"

USER root

RUN mkdir $LOG_DIR \
          && chown app:app $LOG_DIR
          
USER app
RUN source /srv/virtenv/bin/activate && pip install gunicorn==19.4.5

EXPOSE $APP_PORT
VOLUME ["$LOG_DIR"]

CMD gunicorn $APP_MODULE \
    --name $APP_PROCESS_NAME \
    --bind 0.0.0.0:$APP_PORT \
    --workers $APP_WORKERS_COUNT \
    --log-level=$APP_LOG_LEVEL \
    --log-file="$LOG_DIR/gunicorn.log" \
    --access-logfile="$LOG_DIR/access.log" \
    --chdir=$APPLICATION_DIR
