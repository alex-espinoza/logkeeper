class CreateOrganizationTable < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, :null => false, :default => ""

      t.timestamps
    end
  end
end
