class Rss < ActiveRecord::Base

  validate :check_rss

  has_many :follows
  has_many :users, :through => :follows

  def check_rss
    @feed = Feedjira::Feed.fetch_and_parse("#{feed}")
    errors.add(:base, "Not a Valid RSS Feed.") if  @feed == 0 || @feed == nil
  end
end
