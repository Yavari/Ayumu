(function() {
	Ayumu.Views.Categories = Ayumu.Views.Categories || {};
	Ayumu.Views.Categories.IndexView = Backbone.View.extend({
        template: JST["backbone/templates/categories/categories"],
        events: {
        },
        initialize: function () {
            _.bindAll(this, 'render', 'showAllNotes');
            this.collection.bind('reset', this.render);
            this.notes = new Ayumu.Collections.NoteCollection();
			this.notesView = new Ayumu.Views.Notes.IndexView ({collection : this.notes});
			$('#container').append(this.notesView.render().el);
	 		$('#noteTools').html((
	 			new Ayumu.Views.Notes.ToolsView ({collection : this.notes})).render().el);
        },
        render: function () {         
            $(this.el).html(this.template({}));
            this.collection.each(function (category) {
                var view = new Ayumu.Views.Categories.ShowView({
                    model: category,
                    collection: this.notes
                });
                this.$('.categories').append(view.render().el);
            },this);
            return this;
        },
        showAllNotes : function() {
        	this.notes.categoryId = 0;
			this.notes.fetch();
        }
    });
}).call(this);
