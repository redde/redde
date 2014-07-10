//= require jquery
//= require jquery_ujs
//= require admin/lightbox/js/jquery.lightbox-0.5

//= require jquery-migrate-1.2.1
//= require redactor/redactor
//= require redactor/langs/ru
//= require redactor/toolbars/default

//= require jquery.ui.sortable
//=# require admin/jquery.mjs.nestedSortable.js

var lightBox;

$(function(){
  
  lightBox = $("ul.photos:not(.no-lb) a:not(.del)").lightBox();
  
  $('textarea:not(.nowred)').redactor();
 
});