class Category < ActiveRecord::Base
  has_many(:category_note_bindings)
  has_many(:notes, :through => :category_note_bindings)
  
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
  
  def self.search(search)
    return find(:all, :conditions => ['name LIKE ?', "%" + search + "%"])
  end
  
  def self.find_by_path(path)
    return find(:all, :conditions => ["name LIKE ? AND name NOT LIKE ?", path + "%" , path + "%/%" ])
  end
  
  def find_children()
    return Category.find_by_path(self.name + '/')
  end
  
  def find_parent()
    path = self.name.split('/')
    name = (path.first path.size - 1).join('/')
    categories = Category.find_by_path(name)
    if(categories.count() == 1)
      return categories.first()
    else
      return nil
    end
  end
  
  def name=(val)
    if(val[0] != '/') 
      val = '/' + val
    end
    names = val.split('/')
    names.delete_if { |n| n.empty? }
    path =  ""
    (names.first names.size - 1).each do |n|
      path << '/' << n
      Category.find_or_create_by_name(path).save()
    end
    self.update_name(self[:name], val)
  end
  
  def update_name(old, with)
    if(old.nil?)
      self[:name] = with
    else
      self.find_children().each do |category|
        puts category.name
        category.update_name(old, with)
      end
      self[:name] = self[:name].sub(old, with)
    end
    self.save!
  end
end
