class Friend < ActiveRecord::Base

  belongs_to :laboratory
	belongs_to :friend, :class_name => 'Laboratory', :foreign_key =>'friend_id'
	
end
