class LikesController < ApplicationController
  def create
    @protocol = Protocol.find params[:protocol_id]
    @laboratory = @protocol.laboratory
    @like = Like.create(:user_id => current_user.id, :protocol_id => params[:protocol_id])
    respond_to do |format|
      format.js
      format.html { redirect_to laboratory_results_of_the_week_path(@laboratory), :notice => "You liked this!" }
    end
  end

  def destroy
    @protocol = Protocol.find params[:protocol_id]
    @laboratory = @protocol.laboratory
    @like = Like.where("user_id = ? AND protocol_id = ?", current_user.id, params[:protocol_id]).first
    @like.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to laboratory_results_of_the_week_path(@laboratory), :notice => "You no longer like this!" }
    end
  end

end
