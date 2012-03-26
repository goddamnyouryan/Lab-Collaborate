class Renamefeedid < ActiveRecord::Migration
  def self.up
    rename_column :follows, :feed_id, :rss_id
  end

  def self.down
  end
end
