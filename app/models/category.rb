class Category < ActiveRecord::Base
  has_many(:category_note_bindings)
  has_many(:notes, :through => :category_note_bindings)
  has_many(:categories,:order => 'position')
  belongs_to(:category)
  
  validates :name, :presence => true
  before_create :update_position
  
  
  
  def update_position
    self.position = Category.maximum('position', :conditions => ["category_id = ?", category_id])
    if(self.position == nil)
      self.position = 1
    else
      self.position += 1
    end  
  end

  def self.update_category_order(id, order)
    category = find(id)
    order.each_with_index do |item, i|
      binding = category.categories.select {|c| c.id == Integer(item)}.first
      binding.position = i+1
      binding.save
    end
  end
  
  def self.update_note_order(id, order)
    category = find(id)
    order.each_with_index do |item, i|
      binding = category.category_note_bindings.select {|c| c.note_id == Integer(item)}.first
      binding.position = i+1
      binding.save
    end
  end
  
  def self.find_or_create_by_name(name)
  category = find(:first, :conditions => ["lower(name) = ?", Category.get_name_with_path( name.downcase)])
    if category
      return category
    else  
       return new(:name => name)
    end
  end
  
  def self.search(search)
    return find(:all, :conditions => ['name LIKE ?', "%" + search + "%"])
  end
  
  #def self.find_by_path(path)
  #  return find(:all, :conditions => ["name LIKE ? AND name NOT LIKE ?", path + "%" , path + "%/%" ])
  #end
  
  def name=(name)
    name = Category.get_name_with_path(name)
    self.category = self.find_or_create_parent(name)
    self.update_children_names(self[:name], name)
  end
  
  def find_or_create_parent(name)
    tree = get_tree_from_name(name)
    parent = nil
    tree.each do |node|
      c = Category.find_or_create_by_name(node)
      c.category = parent;
      c.save()  
      parent = c
    end
    return parent
  end
  
  def get_tree_from_name(name)
    names = name.split('/')
    names.shift  
    path =  ""
    tree = Array.new()
    (names.first names.size - 1).each do |n|
      path = path + '/' +  n
      tree.push(path)
    end
    return tree
  end
  
  def update_children_names(old, with)
    if(old.nil?)
      self[:name] = with
    else
      self.categories.each do |category|
        category.update_children_names(old, with)
      end
      self[:name] = self[:name].sub(old, with)
    end
    self.save!
  end
  
  def self.get_name_with_path(name)
     if(name[0] == '/')
      return name 
    end
      return '/' + name
  end
end
