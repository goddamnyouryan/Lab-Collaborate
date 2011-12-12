class AddAncestryToWhiteboards < ActiveRecord::Migration
  def self.up
    add_column :whiteboards, :ancestry, :string
    add_index :whiteboards, :ancestry
  end

  def self.down
    remove_column :whiteboards, :ancestry
    remove_index :whiteboards, :ancestry
  end
end
