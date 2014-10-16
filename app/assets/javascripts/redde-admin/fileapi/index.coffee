#= require fileapi
#= require ./jquery.formparams

$ ->
  $box = $('#fileapi')
  return unless $box.length
  
  $box.fileapi
    url: $box.attr('action')
    multiple: true
    maxSize: 20 * FileAPI.MB
    autoUpload: true
    data: $box.formParams()
    dataType: 'html'
    onFileComplete: (e, uiEvt)->
      if uiEvt.status is 200 && uiEvt.error is false
        $('ul.photos').append( uiEvt.result )
      else
        alert('Ошибка загрузки')