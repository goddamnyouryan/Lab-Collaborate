class FollowsController < ApplicationController
  def create
    @rss = Rss.find params[:feed_id]
    @follow = Follow.create(:user_id => current_user.id, :rss_id => @rss.id)
    if @follow.save
      redirect_to rsses_path, :notice => "You are now following this feed."
    else
      redirect_to rsses_path, :notice => "Something went wrong."
    end
  end

  def destroy
    @rss = Rss.find params[:id]
    @follow = Follow.find_by_user_id_and_rss_id(current_user.id, @rss.id)
    @follow.destroy
    redirect_to rsses_path, :notice => "You are no longer following this feed"
  end

end
