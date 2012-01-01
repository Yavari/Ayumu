(function() {
	Ayumu.Models.Note = Backbone.Model.extend({
		url : function() {
		  var base = 'notes';
		  if (this.isNew()) return base;
		  return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
		},
		
		defaults : {
		  title: null,
		  content: null,
		  errors: null
		}
	});

	Ayumu.Collections.NoteCollection = Backbone.Collection.extend({
		url : function() {
			if(this.categoryId > 0)
				return '/categories/' + this.categoryId + '/notes';
			return '/notes';
		},
		model : Ayumu.Models.Notes
	});
}).call(this);
