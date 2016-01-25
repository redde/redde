#= depend_on_asset redde-admin/redactor.css
#= require ./jquery-migrate-1.3.0
#= require ./redactor
#= require ./langs/ru
#= require ./toolbars/default

$ ->
  $('.js-redactor').redactor()
