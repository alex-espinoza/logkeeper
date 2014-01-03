class CreateOrganizationUser < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.integer :user_id, :null => false
      t.integer :organization_id, :null => false

      t.timestamps
    end
  end
end
