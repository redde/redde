#= require jquery-ui/sortable
#= require ./jquery.mjs.nestedSortable.js

$ ->
  $('[data-sort-tree]').each ->
    $this = $(this)

    opts = $this.data('sort-tree')

    if $.isPlainObject( opts ) && opts.url
      url = opts.url
      delete opts.url
    else if (typeof opts == 'string') && opts != ""
      url = opts
      opts = {}

    unless url? || url == ""
      url = location.pathname + "/sort"

    defs =
      # disableNesting: 'no-nest'
      # handle: '[data-sort-tree-handle]'
      # listType: 'ol'
      forcePlaceholderSize: true
      helper: 'clone'
      items: '[data-sort-tree-item]'
      maxLevels: 2
      opacity: .6
      placeholder: 'sort-tree__placeholder'
      revert: 250
      rootID: 'root'
      tabSize: 25
      tolerance: 'pointer'
      toleranceElement: '[data-sort-tree-tolerance]'
      errorClass: 'sort-tree__error'
      update: ->
        serialized = $this.nestedSortable('serialize')
        $.ajax
          method: 'POST'
          url: url
          data: serialized

    $this.nestedSortable $.extend( {}, defs, opts )

    return

  return
