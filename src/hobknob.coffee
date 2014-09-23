# Description:
#   A Hubot script for querying the Hobknob feature toggle service
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HOBKNOB_HOST - the etcd host for hobknob
#   HUBOT_HOBKNOB_PORT - the etcd port for hobknob
#
# Commands:
#   hubot show feature toggles for <application_name>
#
# Author:
#   Chris Riddle

_ = require "underscore"

module.exports = (robot) ->

  host = process.env.HUBOT_HOBKNOB_HOST
  port = process.env.HUBOT_HOBKNOB_PORT
  url = "http://" + host + ":" + port + "/v2/keys/v1/toggles/"

  robot.respond /(show|get)? (feature )?toggles for (\S+)$/i, (msg) ->
    application = msg.match[3]
    msg.http(url + application).get() (err, res, body) ->
      if err?
        msg.send "Error when getting feature toggles for " + application + ": " + err
        return

      bodyJson = JSON.parse(body)

      if bodyJson.errorCode?
        if bodyJson.errorCode == 100
          msg.send "Application not found: " + application
        else
          msg.send "Error when getting feature toggles for " + application + ": " + bodyJson.message
        return

      nodes = bodyJson.node.nodes

      toggles = _.chain(nodes).map((x) ->
        keySplit = x.key.split "/"
        toggleName = keySplit[keySplit.length - 1]
        [toggleName, x.value == "true"]).object().value()

      msg.send application + " toggles:"
      msg.send JSON.stringify(toggles, undefined, 2)
