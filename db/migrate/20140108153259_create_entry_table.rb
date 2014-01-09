class CreateEntryTable < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :text, :null => false
      t.integer :page_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
