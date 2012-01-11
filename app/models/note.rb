class Note < ActiveRecord::Base
  has_many(:category_note_bindings)
  has_many(:categories, :through => :category_note_bindings)
  
  validates :title, :presence => true
  validates :content, :presence => true
  def self.find_all_by_category_id(id)
    return Note.all(:conditions => ['category_note_bindings.category_id == ?', id],
                        :include => [:category_note_bindings],
                        :order => "category_note_bindings.position ASC")
  end
  
  def update_categories(new_categories)
    new_categories(new_categories)
    remove_old_categories(new_categories)
  end
  
  private
  def new_categories(new_categories)
    new_categories.each do |category|
      if !self.categories.any? {|c| c.name.downcase == Category.get_name_with_path(category.downcase)}
        self.categories << Category.find_or_create_by_name(category)
      end
    end  
  end
  
  def remove_old_categories(new_categories)
    self.categories.each do |category|
      if !new_categories.any? {|c| Category.get_name_with_path(c.downcase) == category.name.downcase}
        self.categories.delete(category)
      end
    end
  end
end
