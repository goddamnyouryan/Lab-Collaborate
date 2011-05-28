class CreateLaboratories < ActiveRecord::Migration
  def self.up
    create_table :laboratories do |t|
      t.string :name
      t.integer :school_id
      t.text :info

      t.timestamps
    end
  end

  def self.down
    drop_table :laboratories
  end
end
