class AddRoleToOrganizationUser < ActiveRecord::Migration
  def change
    add_column :organization_users, :role, :string, :default => 'member', :null => false
  end
end
