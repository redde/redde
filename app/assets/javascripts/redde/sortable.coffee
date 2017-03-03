#= require jquery-ui/widgets/sortable

###
variants:
  data-sortable
  data-sortable = 'url'
  data-sortable = {}
  data-sortable = {url: 'url', ...}
###

$ ->
  $("[data-sortable]").each ->
    $this = $(this)

    opts = $this.data('sortable')

    if $.isPlainObject( opts ) && opts.url
      url = opts.url
      delete opts.url
    else if (typeof opts == 'string') && opts != ""
      url = opts
      opts = {}

    unless url? || url == ""
      url = location.pathname + "/sort"

    defs =
      dropOnEmpty: false
      cursor: "crosshair"
      opacity: 0.75
      handle: "[data-sortable-handle]"
      axis: "y"
      items: "[data-sortable-item]"
      scroll: true
      update: ->
        $.ajax
          type: "post"
          data: $this.sortable("serialize") # + '&authenticity_token=#{u(form_authenticity_token)}',
          dataType: "script"
          url: url

    opts = $.extend( {}, defs, opts )
    $this.sortable opts

    return

  return
