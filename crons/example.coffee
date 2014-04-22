"use strict"

Yoi = require "yoi"

class Example extends Yoi.Cron

  count = 0

  execute: ->
    count++

  stop: ->
    super
    console.log "count: #{count}"

exports = module.exports = Example
