class CreateRsses < ActiveRecord::Migration
  def self.up
    create_table :rsses do |t|
      t.string :feed

      t.timestamps
    end
  end

  def self.down
    drop_table :rsses
  end
end
