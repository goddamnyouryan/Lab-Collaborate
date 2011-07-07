class CreateInventories < ActiveRecord::Migration
  def self.up
    create_table :inventories do |t|
      t.string :vendor
      t.string :catalog
      t.text :description
      t.integer :user_id
      t.string :status, {:null => false, :default => "pending"}

      t.timestamps
    end
  end

  def self.down
    drop_table :inventories
  end
end
