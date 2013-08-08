"use strict"
Yoi   = require "yoi"

api =
  register: (server) ->
    server.get "/api", (request, response, next) ->
      try
        rest = new Yoi.Rest request, response
        rest.required ["name"]

        name = rest.parameter "name"
        rest.run 
          "status": "Hello #{name}!"
          "session": "Your session is #{rest.session}"
      catch e
        rest.exception e.code, e.message

module.exports = api
