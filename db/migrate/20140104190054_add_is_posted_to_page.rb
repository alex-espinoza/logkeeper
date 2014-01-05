class AddIsPostedToPage < ActiveRecord::Migration
  def change
    add_column :pages, :is_posted, :boolean, :default => false, :null => false
  end
end
