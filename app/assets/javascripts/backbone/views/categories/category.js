(function() {
	Ayumu.Views.CategoryView = Backbone.View.extend({
		template: JST["backbone/templates/categories/category"],
        tagName: 'li',
		events: {
		},
		initialize: function () {
			_.bindAll(this, 'render');
		},

		render: function () {
			$(this.el).html(this.template(this.model.toJSON()));
			return this;
		}
	});
}).call(this);
