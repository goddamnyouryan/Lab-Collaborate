class ProtocolsController < ApplicationController
  def create
    @protocol = Protocol.create(params[:protocol])
    @protocol.user_id = current_user.id
    @protocol.laboratory_id = current_user.laboratory.id
    if @protocol.save
      flash[:notice] = "Protocol Uploaded Successfully!"
      redirect_to root_path
    else
      redirect_to root_path, :notice => "Something went wrong. Try again!"
    end
  end

end
