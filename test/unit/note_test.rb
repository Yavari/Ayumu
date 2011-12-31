require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test "Can save and find" do
    note = Note.create(:title =>"My first note", :content => "My first content")
    note.categories << Category.new(:name => "Category one")
    note.categories << Category.create(:name => "Category two")
    note.save
    
    note = Note.find note.id
    assert_equal "My first note", note.title
    assert_equal 2, note.categories.count
  end
  
  test "Can find all notes by category" do
    category = Category.new(:name => "test")
    note = Note.create(:title => "1", :content => "content")
    note.categories << category
    note.save!
    
    note = Note.create(:title => "2", :content => "content")
    note.categories << category
    note.save!
    
    notes = Note.find_all_by_category_id category.id
    assert_equal 2, notes.count
  end
  
  test "Can update categories" do
    Category.create :name => "Ruby"
    note = Note.create(:title => "Development", :content => "Some text")
    note.categories << Category.new(:name => "Development")
    note.categories << Category.create(:name => "General")
    note.save

    note = Note.find(note.id)
    note.update_categories ["General", "Software", "other", "ruby"]
    note.save

    note = Note.find(note.id)
    assert_equal 4, note.categories.count

    assert_equal 6, Category.all.count
  end
end
