class AddQuantityToInventories < ActiveRecord::Migration
  def self.up
    add_column :inventories, :quantity, :string
  end

  def self.down
    remove_column :inventories, :quantity
  end
end
