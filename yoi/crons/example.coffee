"use strict"

Yoi = require "yoi"
$   = Yoi.$
C   =
  DOMAIN    : "http://domain.com"
  QUERY     : "/context/"
  CATEGORIES: [
    "music"
    "video"
  ]

class MyCrawler extends Yoi.Crawler

  results : []

  start: =>
    urls = ("#{C.DOMAIN}#{C.QUERY}#{category}" for category in C.CATEGORIES)
    super urls, @page

  finish: ->
    super
    console.log "Results #{@results.length}"
    @results = []
    @stop()

  page: (error, response, body) ->
    next_page = body.find(".pagina_selected_agenda").next().children("a").attr("href")
    @queue "#{next_page}&view=list", @page if next_page

  item: (error, response, body) ->
    post = body.find(".post")
    @results.push post

exports = module.exports = MyCrawler

