(function() {
	Ayumu.Models.Category = Backbone.Model.extend({
		url : function() {
		  var base = 'categories';
		  if (this.isNew()) return base;
		  return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
		},
		
		defaults : {
		  name: "sdf"
		}
	});

	Ayumu.Collections.CategoryCollection = Backbone.Collection.extend({
		url : '/categories',
		model : Ayumu.Models.Category
	});
}).call(this);
