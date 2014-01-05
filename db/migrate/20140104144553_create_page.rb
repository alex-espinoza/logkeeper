class CreatePage < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, :null => false
      t.integer :logbook_id, :null => false

      t.timestamps
    end
  end
end
