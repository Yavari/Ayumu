(function() {
	Ayumu.Views.Categories = Ayumu.Views.Categories || {};
	Ayumu.Views.Categories.ShowView = Backbone.View.extend({
		template: JST["backbone/templates/categories/category"],
        tagName: 'li',
		events: {
			'click a' : 'showCategory'
		},
		
		initialize: function () {
			_.bindAll(this, 'render', 'showCategory');
		},

		render: function () {
			$(this.el).html(this.template(this.model.toJSON()));
			return this;
		},
		
		showCategory: function() {
			var id = $('a', this.el).attr('uid');
			this.collection.categoryId = id;
			this.collection.fetch();
		}
	});
}).call(this);
