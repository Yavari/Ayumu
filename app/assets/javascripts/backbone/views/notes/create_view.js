(function() {
	Ayumu.Views.Notes = Ayumu.Views.Notes || {};
	Ayumu.Views.Notes.CreateView = Backbone.View.extend({
		template: JST["backbone/templates/notes/create"],
		className : "modal hide fade",
		events: {
			'submit form': 'save',	
			'click .danger': 'cancel',
		},
		initialize: function () {
			_.bindAll(this, 'render', 'cancel', 'save');
			this.model = new this.collection.model();
			this.model.set({title : null, content : null});
		},

		render: function(){
			$(this.el).html(this.template(this.model.toJSON()));
			this.$("form").backboneLink(this.model);
			return this;
		},
		show: function(){
			var _this = this;
      		this.model.bind("change:errors", function() {
        		return _this.render();
			});
			$(this.el).modal({
				backdrop: 'static',
				keyboard: false,
				show: true
			});
		},

		
		save: function(e){
			e.preventDefault();
			e.stopPropagation();
			this.model.unset("errors");
			var _this = this;
      		return this.collection.create(this.model.toJSON(), {
			success: function(note) {
			  _this.model = note;
			  _this.cancel();
			},
			error: function(post, jqXHR) {
			  return _this.model.set({
			    errors: $.parseJSON(jqXHR.responseText)
			  });
			}
      });
		},
		
		cancel: function () {
		    $(this.el).modal('hide');
		}
	});
}).call(this);
