// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./bootstrap
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/ayumu
//= require_tree .

$(function () {    
    var categories = new Ayumu.Collections.CategoryCollection();
    var categoriesView = new Ayumu.Views.Categories.IndexView ({collection : categories});
    $('.sidebar .categories').append(categoriesView.render().el);
    categoriesView.showAllNotes();
    categories.fetch();
});
