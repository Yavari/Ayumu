(function() {
	Ayumu.Models.Note = Backbone.Model.extend({
		url : function() {
		  var base = 'notes';
		  if (this.isNew()) return base;
		  return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
		},
		
		defaults : {
		  title: "sdf",
		  content: "sdf"
		}
	});

	Ayumu.Collections.NoteCollection = Backbone.Collection.extend({
		url : '/notes',
		model : Ayumu.Models.Category
	});
}).call(this);
