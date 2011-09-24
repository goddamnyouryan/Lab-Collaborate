class WhiteboardsController < ApplicationController
  after_filter :whiteboard_event, :only => :create
  
  def create
    @whiteboard = Whiteboard.create(params[:whiteboard])
    @laboratory = Laboratory.find params[:whiteboard][:laboratory_id]
    @whiteboard.laboratory_id = @laboratory.id
    @whiteboard.user_id = current_user.id
    if @whiteboard.save
      redirect_to @laboratory, :notice => "message posted!"
    end
  end
  
  def destroy
    @whiteboard = Whiteboard.find params[:id]
    @laboratory = @whiteboard.laboratory
    @whiteboard.destroy
    redirect_to @laboratory, :notice => "whiteboard message removed!"
  end
  
  def whiteboard_event
    if @whiteboard.private == false
      @event = @laboratory.events.create(:kind => "whiteboard", :data => { "user" => "#{@whiteboard.user.id}", "name" => "#{@whiteboard.user.name}"})
    end
  end

end
