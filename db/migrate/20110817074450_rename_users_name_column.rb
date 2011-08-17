class RenameUsersNameColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :fullname
  end

  def self.down
  end
end
