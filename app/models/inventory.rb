class Inventory < ActiveRecord::Base
  belongs_to :user
  
  def mark_as_ordered
    self.update_attributes( :status => "ordered" )
  end

end