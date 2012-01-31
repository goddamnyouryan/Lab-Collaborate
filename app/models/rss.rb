class Rss < ActiveRecord::Base
  
  validate :check_rss
  
  def check_rss
    errors.add(:base, "Not a Valid RSS Feed.") if Feedzirra::Feed.fetch_and_parse(feed) == 0
  end  
end
