class ChangeDataColumnType < ActiveRecord::Migration
  def self.up
    change_column(:events, :data, :text)
  end

  def self.down
  end
end
