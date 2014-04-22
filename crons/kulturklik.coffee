###
Base class for KulturKlik
@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Yoi = require "yoi"
$   = Yoi.$
C   =
  DOMAIN    : "http://www.kulturklik.euskadi.net"
  QUERY     : "/kat-cat/agenda/?view=list&lang=es&kat-cat="
  CATEGORIES: [
    "ikusizko-arteak-artes-visuales"
    "arte-eszenikoak-artes-escenicas"
    "musika-musica"
    "ikus-entzunezkoak-audiovisual"
    "literatura"
    "artxibategiak-liburutegiak-eta-mediatekak-archivos-bibliotecas-y-mediatecas"
    "museoak-museo"
    "ondarea-patrimonio"
    "artisautza-artesania"
    "joerak-tendencias"
    "arlo-berriak-diseinua-bestelakoak-nuevos-medios-diseno-otros"
    "kultura-euskaraz-cultura-en-euskera"
    "sormen-lantegiak-fabricas-de-creacion"
  ]
  CITY:
    BILBAO: 167

class KulturKlik extends Yoi.Crawler

  results : []


  start: =>
    urls = []
    for category in C.CATEGORIES
      urls.push "#{C.DOMAIN}#{C.QUERY}#{category}&mun=#{C.CITY.BILBAO}&data-fecha=2014-04-23"
    super urls, @page

  finish: ->
    super
    for result in @results
      console.log " - #{result.title} (#{result.category} / #{result.type})"
    @results = []

  page: (error, response, body) ->
    next_page = body.find(".pagina_selected_agenda").next().children("a").attr("href")
    @queue "#{next_page}&view=list", @page if next_page

    body.find(".ver_mas > a").each (index, link) =>
      @queue $(link).attr("href"), @item, log = true

  item: (error, response, body) ->
    post = body.find(".post")

    fields = post.find(".eventoCampo")
    result =
      title       : post.find(".post_title > a").attr "title"
      image       : post.find(".foto_evento > img").attr "src"
      description : post.find(".observacionesEvento").text()
      actors      : _field "protagonistas", fields
      category    : post.find(".categorias a").last().attr "title"
      type        : post.find(".category").text()
      tags        : _tags post
      language    : _field "idioma", fields
      price       : _field "precio", fields
      latitude    : post.find("#latitud").val()
      longitude   : post.find("#longitud").val()
      address     : _field "lugar", fields
      provider    :
        name      : post.find("#nombre_centro_es").val()
        url       : post.find("#url_centro_es").val()
        address   : post.find("#direccion_centro_es").val()
      started_at  : post.find(".dtstart > span").attr "title"
      finished_at : post.find(".dtend > span").attr "title"
      schedule    : _field "hora/horario", fields
    @results.push result

exports = module.exports = KulturKlik

_field = (value, fields) ->
  for field in fields
    el = $(field)
    exists = el.children(".eventoCampoTitle").text().toLowerCase().indexOf value
    if exists >= 0
      return el.children(".eventoCampoValue").text()
      break
  return undefined

_tags = (el) ->
  ($(tag).text() for tag in el.find(".post_etiquetas a[rel=tag]"))
