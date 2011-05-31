class CreateWhiteboards < ActiveRecord::Migration
  def self.up
    create_table :whiteboards do |t|
      t.text :message
      t.integer :user_id
      t.integer :laboratory_id

      t.timestamps
    end
  end

  def self.down
    drop_table :whiteboards
  end
end
