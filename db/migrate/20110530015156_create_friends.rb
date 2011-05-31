class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :laboratory_id
      t.integer :friend_id
      t.integer :user_id
      t.string :status, { :null => false, :default => "pending" }

      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
