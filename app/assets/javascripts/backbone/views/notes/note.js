(function() {
	Ayumu.Views.NoteView = Backbone.View.extend({
		template: JST["backbone/templates/notes/note"],
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
