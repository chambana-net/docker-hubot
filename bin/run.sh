#!/bin/bash -

. /app/lib/common.sh

CHECK_BIN node
CHECK_VAR HUBOT_NAME
CHECK_VAR HUBOT_OWNER
CHECK_VAR HUBOT_DESC
CHECK_VAR HUBOT_ADAPTER
CHECK_VAR HUBOT_SCRIPTS
CHECK_VAR NODE_ENV

MSG "Configuring Hubot..."
node -e "console.log(JSON.stringify('$HUBOT_SCRIPTS'.split(',')))" > external-scripts.json
npm install $(node -e "console.log('$HUBOT_SCRIPTS'.split(',').join(' '))")

MSG "Starting Hubot..."

exec "$@"
