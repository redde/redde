#= require fileapi

$ ->
  $box = $('.js-photos-uploader')
  return unless $box.length

  $box.fileapi
    maxSize: 20 * FileAPI.MB
    autoUpload: true
    dataType: 'html'
    multiple: true
    accept: "image/*"
    onFileComplete: (e, uiEvt)->
      if uiEvt.status is 200 && uiEvt.error is false
        $('.js-photos').append( uiEvt.result )
      else
        alert('Ошибка загрузки')
