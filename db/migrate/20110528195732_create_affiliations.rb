class CreateAffiliations < ActiveRecord::Migration
  def self.up
    create_table :affiliations do |t|
      t.integer :user_id
      t.integer :laboratory_id
      t.string :status, {:null => false, :default => "pending" }

      t.timestamps
    end
  end

  def self.down
    drop_table :affiliations
  end
end
