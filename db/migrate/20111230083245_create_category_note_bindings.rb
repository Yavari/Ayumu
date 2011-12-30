class CreateCategoryNoteBindings < ActiveRecord::Migration
  def change
    create_table :category_note_bindings do |t|
      t.integer :position
      t.integer :category_id, :null => false
      t.integer :note_id, :null => false

      t.timestamps
    end
  end
end
