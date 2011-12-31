(function() {
	Ayumu.Views.MainWindowNotesView = Backbone.View.extend({
        template: JST["backbone/templates/notes/notes"],
        events: {
        },
        initialize: function () {
            _.bindAll(this, 'render');
            this.collection.bind('reset', this.render);
         	this.collection.bind('add', this.render);
        },
        render: function () {       
            $(this.el).html(this.template({}));
            this.collection.each(function (note) {
                var view = new Ayumu.Views.NoteView({
                    model: note,
                    collection: this.collection
                });
                this.$('.notes').append(view.render().el);
            },this);
            return this;
        }
    });
}).call(this);
