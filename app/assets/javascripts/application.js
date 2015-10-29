// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require turbolinks
//= require_tree .

if (history && history.pushState) {
      $(function() {
$('a[data-toggle="tab"]').on("click", function(e) {
$.getScript(this.href);
history.pushState(null, document.title, this.href);
if ( document.activeElement.dataset.target == "#" ){
document.activeElement.parentElement.click();
}
console.log ('^^^^'+ this.href + "&&&" + document.activeElement.dataset.target);
e.preventDefault();
});

$('#header-nav').on("click", function(e) {
$.getScript(this.href);
history.pushState(null, document.title, this.href);
console.log ('#####'+ location.href);
});

$(window).bind("popstate", function() {
var activeTab = $('[href="' + location.pathname + '"]');
if (activeTab.length) {
activeTab.tab('show');
} 
else {
$('.nav-tabs a:first').tab('show')
}
$.getScript(location.href);
console.log ('****'+ location.href);
});
});

}

