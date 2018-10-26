FROM chambana/node:latest

MAINTAINER Josh King <jking@chambana.net>

ENV HUBOT_NAME="bot" HUBOT_OWNER="No owner specified." \
    HUBOT_DESC="A simple helpful robot." \
    HUBOT_SCRIPTS=hubot-diagnostics,hubot-help HUBOT_ADAPTER=campfire \
    NODE_ENV=production

WORKDIR /srv/hubot

RUN useradd -r -m -d /srv/hubot hubot && \
    chown -R hubot:hubot /srv/hubot && \
    npm install -g yo generator-hubot@1.1.0

USER hubot
    
RUN yo hubot --name=${HUBOT_NAME} --owner=${HUBOT_OWNER} --description=${HUBOT_DESC} --defaults

ADD .

## Add startup script.                                                                                                                                                                                                                                                                                                                                                                                                                    
ADD bin/run.sh /app/bin/run.sh                                                                                                                                                                                                                                                                                                                                                                                                            
RUN chmod 0755 /app/bin/run.sh                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                          
ENTRYPOINT ["/app/bin/run.sh"]                                                                                                                                                                                                                                                                                                                                                                                                            
CMD ["./bin/hubot", "-n", "${HUBOT_NAME}", "-a", "${HUBOT_ADAPTER}"] 
