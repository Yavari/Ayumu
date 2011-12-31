(function() {
	Ayumu.Views.SidebarCategoriesView = Backbone.View.extend({
        template: JST["backbone/templates/categories/categories"],
        events: {
        },
        initialize: function () {
            _.bindAll(this, 'render');
            this.collection.bind('reset', this.render);
        },
        render: function () {         
            $(this.el).html(this.template({}));
            this.collection.each(function (category) {
                var view = new Ayumu.Views.CategoryView({
                    model: category,
                    collection: this.collection
                });
                this.$('.categories').append(view.render().el);
            },this);
            return this;
        }
    });
}).call(this);
