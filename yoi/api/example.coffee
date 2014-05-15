"use strict"
Yoi   = require "yoi"

module.exports = (server) ->

  server.get "/api", (request, response, next) ->
    rest = new Yoi.Rest request, response
    rest.required ["name"]
    name = rest.parameter "name"
    rest.run
      "status": "Hello #{name}!"
      "session": "Your session is #{rest.session}"


  server.get "/api/notfound", (request, response, next) ->
    rest = new Yoi.Rest request, response
    rest.badRequest()


  server.get "/api/tasks", (request, response, next) ->
    rest = new Yoi.Rest request, response

    Yoi.Deploy.tasks().then (error, console) ->
      rest.run "tasks": console
