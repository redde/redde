#= require jquery-ui/sortable
#= require ./jquery.mjs.nestedSortable.js

$ ->
  $('ol.sortable').nestedSortable
    disableNesting: 'no-nest'
    forcePlaceholderSize: true
    handle: 'div'
    helper: 'clone'
    items: 'li'
    maxLevels: 2
    opacity: .6
    placeholder: 'placeholder'
    revert: 250
    rootID: 'root'
    tabSize: 25
    tolerance: 'pointer'
    toleranceElement: '> div'
    update: ->
      serialized = $(this).nestedSortable('serialize')
      $.ajax
        method: 'POST'
        url: location.pathname + '/sort'
        data: serialized