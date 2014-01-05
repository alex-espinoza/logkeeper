class AddScheduledAtToPage < ActiveRecord::Migration
  def change
    add_column :pages, :scheduled_at, :datetime, :null => false
  end
end
