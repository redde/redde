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

function goTo(event,url) {
	if (!$(event.target).hasClass("dont-move")) {
		window.location = url;
	};
};

var lightBox;

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("div").hide();
}

function remove_fields_gal(link) {
  $(link).prev("input[type=hidden]").val("1");
  hideElem($(link).closest("tr"));
  function hideElem(el) {
    el.hide();
    el.hasClass("bot") ? el.hide() : hideElem(el.next("tr"));
  };
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  var innerPrint = $(link).before(content.replace(regexp, new_id));
}

function add_fields_gal(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  var innerPrint = $(link).closest("tfoot").prev("tbody").append(content.replace(regexp, new_id));
}

function selectCheckbox(el) {
  el.checked ? $(el).closest("tr").addClass("selected") : $(el).closest("tr").removeClass("selected");
}

function selectLang(el) {
	var show_lang = el.removeClass("selected").attr("class");
  	$("tr, tbody").filter("."+show_lang).show();
  	var hide_lang = el.siblings("a").removeClass("selected").attr("class");
  	$("tr, tbody").filter("."+hide_lang).hide();
  	el.addClass("selected");
}

$(function(){
	
	$("#onchange-submit").find("select, input").change(function(){
		$(this).closest("form").submit();
	});	
		
  lightBox = $("ul.photos:not(.no-lb) a:not(.del)").lightBox();
  
	$('textarea:not(.nowred)').redactor({
		path: '/assets/redactor',
		load: false
	});  

	setTimeout(function(){
		selectLang($("tr.lang").find("a.selected"));
	}, 500);
	;
	$('a.ru_lang, a.en_lang').click(function(e) {
		selectLang($(this));
		e.preventDefault();
	});
 
});