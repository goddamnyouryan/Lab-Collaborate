class AddExtraInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :school_id, :integer
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end

  def self.down
    remove_column :users, :address
    remove_column :users, :phone
    remove_column :users, :school_id
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
