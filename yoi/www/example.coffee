"use strict"
Yoi   = require "yoi"

module.exports = (server) ->

  server.get "/", (request, response, next) ->
    site = new Yoi.Site request, response
    bindings =
      session: site.session
    site.template "index", bindings

  server.get "/login", (request, response, next) ->
    site = new Yoi.Site request, response
    bindings =
      session: "tapquo-rulz-since-2010"
    site.template "index", bindings, bindings.session

  server.get "/logout", (request, response, next) ->
    site = new Yoi.Site request, response
    site.redirect "/", null
