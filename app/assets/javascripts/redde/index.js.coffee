#= require jquery
#= require jquery_ujs

# Пока подключаем все подряд, потом сделать кастомизацию
#= require ./sortable
#= require ./sortTree
#= require ./fileapi
#= require ./redactor
#= require ./file

$ ->
  $(document).on 'click', '[data-href]', (e)->
    location.href = $(e.currentTarget).data('href')
