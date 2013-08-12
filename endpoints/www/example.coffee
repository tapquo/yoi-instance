"use strict"
Yoi   = require "yoi"

module.exports = (server) ->
    server.get "/", (request, response, next) ->
      Yoi.template "index", null, response, "session-key"
