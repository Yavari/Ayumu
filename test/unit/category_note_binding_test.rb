require 'test_helper'

class CategoryNoteBindingTest < ActiveSupport::TestCase
  test "Can save and find" do
    note = Note.create(:title => "Development", :content => "Some text")
    CategoryNoteBinding.create(:note => note, :category => Category.create(:name => "Development"))
    CategoryNoteBinding.create(:note => note, :category => Category.create(:name => "General"))

    note = Note.find(note.id)
    assert_equal 1, note.category_note_bindings[0].position
    assert_equal 1, note.category_note_bindings[1].position
    assert_equal 2, note.categories.count
  end

end
