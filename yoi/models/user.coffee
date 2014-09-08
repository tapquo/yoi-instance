"use strict"

Yoi       = require "yoi"
Schema    = Yoi.Mongoose.Schema
db        = Yoi.Mongo.connections.primary

User = new Schema
  mail            : type: String
  password        : type: String
  created_at        : type: Date, default: Date.now

exports = module.exports = db.model "User", User
