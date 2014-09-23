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
  port = process.env.HUBOT_HOBKNOB_HOST
  url = "http://" + host + ":" + port + "/v2/keys/v1/toggles/"

  robot.respond /show feature toggles for (\S*)$/, (msg) ->
    application = msg.match[1]
    msg.http(url + application).get (err, res, body) ->
      if err?
        if res.code == 200
          msg.send "No feature toggles found for " + application
        else
          msg.send "Error when getting feature toggles for " + application + ": " + err
        return

      var bodyJson = JSON.parse(body)
      var nodes = bodyJson.node.nodes

      toggles = _.chain(nodes).map((x) -> [x.key, x.value == "true"]).object().value()
      msg.send JSON.stringify(toggles)
