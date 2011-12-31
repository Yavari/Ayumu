class Category < ActiveRecord::Base
  has_many :category_note_bindings
  has_many :notes, :through => :category_note_bindings
  
  validates :name, :presence => true
  
  def self.update_order(id, order)
    category = find(id)
    order.each_with_index do |item, i|
      binding = category.category_note_bindings.select {|c| c.note_id == Integer(item)}.first
      binding.position = i+1
      binding.save
    end
  end
  
  def self.find_or_create_by_name(name)
  category = find(:first, :conditions => ["lower(name) = ?", name.downcase])
    if category
      return category
    else  
       return new(:name => name)
    end
  end
end
