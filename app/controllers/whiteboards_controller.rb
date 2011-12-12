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
    if @whiteboard.children
      @whiteboard.children.each do |child|
        child.destroy
      end
    end
    @whiteboard.destroy
    redirect_to @laboratory, :notice => "whiteboard message removed!"
  end
  
  def whiteboard_event
    if @whiteboard.private == false
      @event = @laboratory.events.create(:kind => "whiteboard", :data => { "user" => "#{@whiteboard.user.id}", "name" => "#{@whiteboard.user.name}", "message" => "#{@whiteboard.message}"})
    end
  end
  
  def reply
    @whiteboard = Whiteboard.new(:parent_id => params[:parent_id], :laboratory_id => params[:laboratory_id])
    respond_to do |format|
      format.js
    end
  end
  
  def create_reply
    @whiteboard = Whiteboard.create(params[:whiteboard])
    @laboratory = Laboratory.find params[:whiteboard][:laboratory_id]
    @whiteboard.laboratory_id = params[:whiteboard][:laboratory_id]
    @whiteboard.user_id = current_user.id
    if @whiteboard.parent != nil && @whiteboard.parent.private
      @whiteboard.private = true
    end
    if @whiteboard.save
      if @laboratory == current_user.laboratory
        @whiteboards = @laboratory.whiteboards.order.arrange(:order => "created_at DESC")
      else
        @whiteboards = @laboratory.whiteboards.where("private = ?", false).arrange(:order => "created_at DESC")
      end
      respond_to do |format|
        format.js
      end
    end
  end

end
