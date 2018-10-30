#!/bin/bash -

. /app/lib/common.sh

CHECK_BIN node
CHECK_VAR HUBOT_NAME
CHECK_VAR HUBOT_OWNER
CHECK_VAR HUBOT_DESC
CHECK_VAR HUBOT_ADAPTER
CHECK_VAR HUBOT_EXTERNAL_SCRIPTS
CHECK_VAR NODE_ENV

MSG "Configuring Hubot..."
node -e "console.log(JSON.stringify('$HUBOT_EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json
npm install $(node -e "console.log('$HUBOT_EXTERNAL_SCRIPTS'.split(',').join(' '))")
if [[ "$HUBOT_ADAPTER" != "campfire" ]] && [[ "$HUBOT_ADAPTER" != "shell" ]]; then
  npm install $(node -e "console.log('$HUBOT_ADAPTER'.startsWith('hubot-') ? '$HUBOT_ADAPTER' : 'hubot-'.concat('$HUBOT_ADAPTER'))")
fi
export HUBOT_ADAPTER=$(node -e "console.log('$HUBOT_ADAPTER'.startsWith('hubot-') ? '$HUBOT_ADAPTER'.slice('hubot-'.length) : '$HUBOT_ADAPTER')")

MSG "Starting Hubot..."

exec "$@"
