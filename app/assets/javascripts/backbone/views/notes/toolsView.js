(function() {
	Ayumu.Views.NoteToolsView = Backbone.View.extend({
		template: JST["backbone/templates/notes/tools"],
		events: {
			'click .add': 'add_note',
		},
		initialize: function () {
			_.bindAll(this, 'render');
		},

		render: function () {
			$(this.el).html(this.template());
			return this;
		},
		
		add_note: function () {
		 	this.addNoteView = new Ayumu.Views.Notes.Create ({collection : this.collection});
			$('#addNoteView').html(this.addNoteView.render().el);
			this.addNoteView.show();
		}
	});
}).call(this);
