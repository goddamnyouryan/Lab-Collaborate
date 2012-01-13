class ProtocolsController < ApplicationController
  
  after_filter :protocol_event, :only => :create
  
  def create
    @protocol = Protocol.create(params[:protocol])
    @protocol.user_id = current_user.id
    @protocol.laboratory_id = current_user.laboratory.id
    if @protocol.save
      if @protocol.caption.nil?
        flash[:notice] = "Successfully uploaded library item."
        redirect_to laboratory_protocols_path(@protocol.laboratory)
      else
        @protocol.update_attributes( :category => "picture", :name => @protocol.caption)
        @protocol.tag_list = "Results of the Week, #{@protocol.created_at.strftime('%m/%d/%Y')}"
        @protocol.save
        flash[:notice] = "Successfully uploaded Results of the Week!"
        redirect_to laboratory_results_of_the_week_path(@protocol.laboratory)
      end
    else
      redirect_to laboratory_library_path(@protocol.laboratory), :notice => "Something went wrong. Try again!"
    end
  end
  
  def destroy
    @protocol = Protocol.find params[:id]
    @laboratory = @protocol.laboratory
    @protocol.destroy
    redirect_to laboratory_library_path(@laboratory), :notice => "Library upload Removed!"
  end
  
  def edit
    @protocol = Protocol.find params[:id]
  end
  
  def update
    @protocol = Protocol.find params[:id]
    @laboratory = @protocol.laboratory
    @protocol.update_attributes(params[:protocol])
    if @protocol.save
      redirect_to laboratory_library_path(@laboratory)
    end
  end
  
  def protocol_event
    if @protocol.private == false
      if @protocol.caption?
        @event = @protocol.laboratory.events.create(:kind => "results_of_the_week", :data => { "caption" => "#{@protocol.caption}" })
      else
        @event = @protocol.laboratory.events.create(:kind => "protocol", :data => { "name" => "#{@protocol.name}", "category" => "#{@protocol.category}" })
      end
    end
  end
  
  def results_of_the_week
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.new
  end
  
  def upload_results
    @laboratory = Laboratory.find params[:laboratory_id]
    @protocol = Protocol.create(params[:attachment])
    @protocol.caption = params[:caption]
    @protocol.user_id = current_user.id
    @protocol.category = "picture"
    @protocol.laboratory_id = current_user.laboratory.id
    if @protocol.save
      flash[:notice] = "Successfully uploaded Results of the Week!"
      redirect_to laboratory_results_of_the_week_path(@laboratory)
    else
      redirect_to laboratory_results_of_the_week_path(@laboratory), :notice => "Something went wrong. Try again!"
    end
  end

end
