class CreateLogbook < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.string :name, :null => false
      t.integer :organization_id, :null => false

      t.timestamps
    end
  end
end
