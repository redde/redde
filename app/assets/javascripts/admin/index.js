//= require jquery
//= require jquery_ujs
//= require admin/lightbox/js/jquery.lightbox-0.5

//= require redactor

//= require jquery-ui/sortable

//= require_tree .
//= stub ./jquery.mjs.nestedSortable.js

var lightBox;

$(function(){

  lightBox = $("ul.photos:not(.no-lb) a:not(.del)").lightBox();

  $('textarea:not(.nowred)').redactor();

});
