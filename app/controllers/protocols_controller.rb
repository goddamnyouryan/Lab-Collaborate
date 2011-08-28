class ProtocolsController < ApplicationController
  def create
    @protocol = Protocol.create(params[:protocol])
    @protocol.user_id = current_user.id
    @protocol.laboratory_id = current_user.laboratory.id
    if @protocol.save
      flash[:notice] = "Successfully uploaded library item."
      redirect_to laboratory_protocols_path(@protocol.laboratory)
    else
      redirect_to laboratory_protocols_path(@protocol.laboratory), :notice => "Something went wrong. Try again!"
    end
  end
  
  def destroy
    @protocol = Protocol.find params[:id]
    @laboratory = @protocol.laboratory
    @protocol.destroy
    redirect_to laboratory_protocols_path(@laboratory), :notice => "Library upload Removed!"
  end

end
