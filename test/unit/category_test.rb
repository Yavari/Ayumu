require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "Can update order" do
    category = Category.create :name => "test"

    note1 = Note.new(:title => "1", :content => "content")
    note1.categories <<  category
    note1.save!

    note2 = Note.new(:title => "2", :content => "content")
    note2.categories <<  category
    note2.save!

    note3 = Note.new(:title => "3", :content => "content")
    note3.categories <<  category
    note3.save!

    notes = Note.find_all_by_category_id category.id
    assert_equal 3, notes.count
    assert_equal 1, notes.first.category_note_bindings.first.position

    Category.update_order category.id, [note3.id, note1.id, note2.id]
    notes = Note.find_all_by_category_id category.id
    assert_equal 3, notes.count
    assert_equal note3.id, notes[0].id
    assert_equal note1.id, notes[1].id
    assert_equal note2.id, notes[2].id
  end
  
  test "can search for categories" do
    Category.create :name => "cat1"
    Category.create :name => "cat2"
    Category.create :name => "1cat"
    Category.create :name => "2cat"
    Category.create :name => "hello"
    categories = Category.search("cat")
    assert_equal 2, categories.count
  end
end
