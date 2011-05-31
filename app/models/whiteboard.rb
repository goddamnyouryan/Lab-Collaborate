class Whiteboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :laboratory
end
