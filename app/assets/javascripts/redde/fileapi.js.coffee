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
        $photo = $( uiEvt.result )
        $photo.appendTo( $('.js-photos') )
        if !$box.find("input[name='redde_photo[imageable_id]']").val()
          id = $photo.attr('id').replace(/\D/gi, '')
          $form = $('form[data-redde]')
          formId = $form.attr('id')
          objectName = $form.data('redde').objectName
          $photo.append("<input type='hidden' name='#{objectName}[photo_ids][]' value='#{id}' form='#{formId}'>")
      else
        alert('Ошибка загрузки')
