class AddLaboratoryIdToInventories < ActiveRecord::Migration
  def self.up
    add_column :inventories, :laboratory_id, :integer
  end

  def self.down
    remove_column :inventories, :laboratory_id
  end
end
