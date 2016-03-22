class Rfile
  constructor: (@$box, condition)->
    @$box.off('click.rfile touch.rfile', '.jsr-file--del')
    if condition
      @$box.find('.jsr-file--del').removeAttr('hidden')
      @$box.on 'click.rfile touch.rfile', '.jsr-file--del', $.proxy(@, 'delete')
    else
      @$box.find('.jsr-file--del').attr('hidden', "")

  delete: ->
    $wrap = @$box.find('.jsr-file--wrap')
    $wrap.html $wrap.html()
    @$box.find('.jsr-file--name').empty()
    @$box.find('.jsr-file--del').attr('hidden', '')
    delete(this)

$ ->
  $(document).on 'change', '.jsr-file input:file', (e)->
    files = e.currentTarget.files
    $box = $(this).closest('.jsr-file')
    $box.find('.jsr-file--name').map ->
      if files.length > 0
        throw new Error('Не работает для multiple') if files.length > 1
        $(this).text(files[0].name)
      else
        $(this).empty()
      new Rfile($box, !!files.length)
