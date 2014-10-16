#= require jquery-ui/sortable

###
variants:
  data-sortable
  data-sortable = 'url'
  data-sortable = {}
  data-sortable = {url: 'url', ...}
###

$ ->
  $("[data-sortable]").each ->
    self = $(this)

    opts = self.data('sortable')

    if $.isPlainObject( opts ) && opts.url
      url = opts.url
      delete opts.url
    else if (typeof opts is 'string') && opts isnt ""
      url = opts
      opts = {}

    unless url? || url is ""
      url = location.pathname + "/sort"

    defs =
      dropOnEmpty: false
      cursor: "crosshair"
      opacity: 0.75
      handle: ".handle"
      axis: "y"
      items: "tr"
      scroll: true
      update: ->
        $.ajax
          type: "post"
          data: self.sortable("serialize") # + '&authenticity_token=#{u(form_authenticity_token)}',
          dataType: "script"
          url: url

    opts = $.extend( {}, defs, opts )
    self.sortable opts

    return

  return
