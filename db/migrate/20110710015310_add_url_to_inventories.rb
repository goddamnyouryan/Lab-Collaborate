class AddUrlToInventories < ActiveRecord::Migration
  def self.up
    add_column :inventories, :url, :string
  end

  def self.down
  end
end
