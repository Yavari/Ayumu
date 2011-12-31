(function() {
	Ayumu.Views.Notes = Ayumu.Views.Notes || {};
	Ayumu.Views.Notes.Create = Backbone.View.extend({
		template: JST["backbone/templates/notes/create"],
		className : "modal hide fade",
		events: {
			'click .success': 'save',	
			'click .danger': 'cancel',
		},
		initialize: function () {
			_.bindAll(this, 'render', 'cancel', 'save');
		},

		render: function () {
			$(this.el).html(this.template());
			return this;
		},
		show: function(){
			$(this.el).modal({
				backdrop: 'static',
				keyboard: false,
				show: true
			});
		},
		
		save: function(){
			var title = $("input[name='title']", this.el).val();
			var content = $("textarea[name='content']", this.el).val();
			var note = new Ayumu.Models.Note();
			note.set({title: title, content: content});
			note.save();
			this.collection.add(note);
			this.cancel();
		},
		
		cancel: function () {
		    $(this.el).modal('hide');
		}
	});
}).call(this);
