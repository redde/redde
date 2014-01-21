// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require admin/swfobject
//= require admin/uploadify/jquery.uploadify.min
//= require admin/uploadifive/jquery.uploadifive
//= require admin/lightbox/js/jquery.lightbox-0.5
//= require admin/jquery.ui.nestedSortable
//= require admin/zen_textarea.min
//= require admin/redactor/redactor
//= require admin/redactor/langs/ru
//= require admin/redactor/toolbars/default

var lightBox;

$(function(){
	
  lightBox = $("ul.photos:not(.no-lb) a:not(.del)").lightBox();
  
	$('textarea:not(.nowred)').redactor({
		path: '/assets/redactor',
		load: false
	});
 
});