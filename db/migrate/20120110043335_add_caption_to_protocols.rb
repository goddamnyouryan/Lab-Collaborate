class AddCaptionToProtocols < ActiveRecord::Migration
  def self.up
    add_column :protocols, :caption, :string
  end

  def self.down
    remove_column :protocols, :caption
  end
end
