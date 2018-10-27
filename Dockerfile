FROM chambana/node:latest

MAINTAINER Josh King <jking@chambana.net>

ENV HUBOT_NAME="bot" HUBOT_OWNER="No owner specified." \
    HUBOT_DESC="A simple helpful robot." \
    HUBOT_SCRIPTS=hubot-diagnostics,hubot-help HUBOT_ADAPTER=campfire \
    NODE_ENV=production

WORKDIR /srv/hubot

RUN useradd -r -m -d /srv/hubot hubot && \
    mkdir -p /root/.config/configstore && \
    chmod -R g+rwX /root /root/.config /root/.config/configstore && \
    npm install -g yo generator-hubot@1.1.0 && \
    yo hubot --name=${HUBOT_NAME} --owner=${HUBOT_OWNER} --description=${HUBOT_DESC} --defaults && \
    chown -R hubot:hubot /srv/hubot

## Add startup script.                                                                                                                                                                                                                                                                                                                                                                                                                    
ADD bin/run.sh /app/bin/run.sh                                                                                                                                                                                                                                                                                                                                                                                                            
RUN chmod 0755 /app/bin/run.sh                                                                                                                                                                                                                                                                                                                                                                                                            
USER hubot

ENTRYPOINT ["/app/bin/run.sh"]                                                                                                                                                                                                                                                                                                                                                                                                            
CMD ["./bin/hubot", "-n", "${HUBOT_NAME}", "-a", "${HUBOT_ADAPTER}"] 
