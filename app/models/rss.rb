class Rss < ActiveRecord::Base
  
  validate :check_rss
  
  def check_rss
    @feed = Feedzirra::Feed.fetch_and_parse("#{feed}")
    errors.add(:base, "Not a Valid RSS Feed.") if  @feed == 0 || @feed == nil
  end  
end
