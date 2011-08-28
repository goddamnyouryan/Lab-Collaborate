class InventoriesController < ApplicationController
  
  def index
    @laboratory = Laboratory.find params[:laboratory_id]
    @inventories = @laboratory.inventories.order("created_at DESC")
    if params[:search]
      @inventories = @laboratory.inventories.where("LOWER(vendor) LIKE ? OR LOWER(catalog) LIKE ? OR LOWER(description) LIKE ?", "%#{params[:search].to_s.downcase}%","%#{params[:search].to_s.downcase}%","%#{params[:search].to_s.downcase}%")
    end
  end
  
  def new
    @laboratory = Laboratory.find params[:laboratory_id]
    @inventory = Inventory.new
  end
  
  def create
    @laboratory = Laboratory.find params[:laboratory_id]
    @inventory = @laboratory.inventories.create(params[:inventory])
    @inventory.user_id = current_user.id
    if @inventory.save
      redirect_to laboratory_inventories_path, :notice => "Order placed!"
    end
  end
  
  def mark_as_ordered
    @inventory = Inventory.find params[:inventory_id]
    @inventory.mark_as_ordered
    respond_to do |format|
      format.js
    end
  end
  
end
