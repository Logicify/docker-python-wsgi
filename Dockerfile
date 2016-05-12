FROM logicify/python3
MAINTAINER "Dmitry Berezovsky <dmitry.berezovsky@logicify.com>"

ENV APP_PROCESS_NAME="wsgi-application"
ENV APP_MODULE="wsgi"
ENV APP_WORKERS_COUNT="4"
ENV TIMEOUT="30"
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
ADD start-gunicorn.sh /home/app/start-gunicorn.sh
#RUN chmod +x /home/app/start-gunicorn.sh

CMD /home/app/start-gunicorn.sh
