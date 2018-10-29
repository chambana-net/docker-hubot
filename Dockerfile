FROM chambana/node:latest

MAINTAINER Josh King <jking@chambana.net>

ENV HUBOT_NAME="bot" HUBOT_OWNER="No owner specified." \
    HUBOT_DESC="A simple helpful robot." \
    HUBOT_EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help HUBOT_ADAPTER=shell \
    NODE_ENV=development XDG_CONFIG_HOME=/srv/hubot/.config HOME=/srv/hubot \
    npm_config_cache=/srv/hubot/.npm npm_config_devdir=/srv/hubot/.node-gyp

## Add startup script.                                                                                                                                                                                                                                                                                                                                                                                                                    
ADD bin/run.sh /app/bin/run.sh                                                                                                                                                                                                                                                                                                                                                                                                            
RUN useradd -m -d /srv/hubot hubot && \
    chmod 0755 /app/bin/run.sh && \
    npm install -g yo generator-hubot@1.1.0 && \
    chown -R hubot:hubot /srv/hubot

USER hubot:hubot

WORKDIR /srv/hubot

RUN yo hubot --name=${HUBOT_NAME} --owner=${HUBOT_OWNER} --description=${HUBOT_DESC} --defaults

ENTRYPOINT ["/app/bin/run.sh"]                                                                                                                                                                                                                                                                                                                                                                                                            
CMD ["sh", "-c", "./bin/hubot -n ${HUBOT_NAME} -a ${HUBOT_ADAPTER}"] 
