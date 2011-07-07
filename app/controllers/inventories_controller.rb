class InventoriesController < ApplicationController
  
  def index
    @laboratory = Laboratory.find params[:laboratory_id]
    @inventories = @laboratory.users.map(&:inventories)[0]
  end
  
  def new
    @inventory = Inventory.new
  end
  
  def create
    @inventory = Inventory.create(params[:inventory])
    @inventory.user_id = current_user.id
    if @inventory.save
      redirect_to laboratory_inventories_path, :notice => "Order placed!"
    end
  end
  
end
