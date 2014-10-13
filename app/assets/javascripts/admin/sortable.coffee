$ ->
  $(".js-sortable").each ->
    self = $(this)

    url = self.data('sortable')

    # if typeof opts is 'string'
    #   url = opts

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

    opts = $.extend {}, defs, opts

    self.sortable opts

    return

  return
