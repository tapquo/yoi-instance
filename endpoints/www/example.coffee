"use strict"
Yoi   = require "yoi"

Main =
  register: (server) ->
    server.get "/", (request, response, next) ->
      Yoi.template "index", null, response, "session-key"

module.exports = Main
