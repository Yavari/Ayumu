class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :content,    :limit => 2147483647

      t.timestamps
    end
  end
end
