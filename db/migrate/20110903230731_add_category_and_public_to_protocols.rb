class AddCategoryAndPublicToProtocols < ActiveRecord::Migration
  def self.up
    add_column :protocols, :category, :string, {:null => false, :default => "protocol"}
    add_column :protocols, :private, :boolean, { :null => false, :default => false }
  end

  def self.down
    remove_column :protocols, :private
    remove_column :protocols, :category
  end
end
