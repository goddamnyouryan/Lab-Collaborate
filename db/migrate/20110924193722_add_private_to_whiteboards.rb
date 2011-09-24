class AddPrivateToWhiteboards < ActiveRecord::Migration
  def self.up
    add_column :whiteboards, :private, :boolean, { :null => false, :default => false }
  end

  def self.down
  end
end
