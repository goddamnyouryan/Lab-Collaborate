class RssesController < ApplicationController
  
  def index
    if user_signed_in?
      @rss = current_user.rsses
    else
      @rss = Rss.all
    end
    @all = Rss.all
    @entries = Array.new
    @rss.each do |rss|
      feed = Feedzirra::Feed.fetch_and_parse(rss.feed)
      feed.entries.each do |entry|
        unless entry.published.nil?
          @entries << entry
        end
      end
    end
    @entries = @entries.sort_by{ |entry| entry.published }.reverse
    @entries = Kaminari.paginate_array(@entries).page(params[:page]).per(25)
  end

  def new
    @rss = Rss.new
  end

  def create
    @rss = Rss.create(params[:rss])
    if @rss.save
      redirect_to new_rss_path, :notice => "New Feed Added"
    else
      render :new
    end
  end

  def show
    @feed = Feedzirra::Feed.fetch_and_parse((Rss.find params[:id]).feed)
  end

  def destroy
    @feed = Rss.find params[:id]
    @feed.destroy
    redirect_to new_rss_path, :notice => "Feed Removed."
  end

end
