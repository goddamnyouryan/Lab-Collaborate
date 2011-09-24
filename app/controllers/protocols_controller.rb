class ProtocolsController < ApplicationController
  after_filter :protocol_event, :only => :create
  def create
    @protocol = Protocol.create(params[:protocol])
    @protocol.user_id = current_user.id
    @protocol.laboratory_id = current_user.laboratory.id
    if @protocol.save
      flash[:notice] = "Successfully uploaded library item."
      redirect_to laboratory_protocols_path(@protocol.laboratory)
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
      @event = @protocol.laboratory.events.create(:kind => "protocol", :data => { "name" => "#{@protocol.name}", "category" => "#{@protocol.category}" })
    end
  end

end
