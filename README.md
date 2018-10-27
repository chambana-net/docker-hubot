# docker-hubot
A docker container for running a modern, customizable instance of the Hubot chatops bot.

## Usage
This container installs and runs a customizable v3.x instance of [Hubot](https://hubot.github.com). It supports the following environment variables for configuration. Scripts and adapters may require other environment variables for configuration.
* `HUBOT_NAME`: The name of your bot (default: `bot`)
* `HUBOT_OWNER`: The identity of the operator of this bot instance (default: `No owner specified`).
* `HUBOT_DESC`: A description of this bot instance (default: `A simple helpful robot.`).
* `HUBOT_SCRIPTS`: A comma-separated list of Hubot scripts to be installed at runtime (default: `hubot-diagnostics,hubot-help`).
* `HUBOT_ADAPTER`: The Hubot adapter to run (default: `campfire`).
* `NODE_ENV`: A common variable used to set whether this is a development or production instance of a Node.js script (default: `production`).
