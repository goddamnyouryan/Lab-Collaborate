class Whiteboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :laboratory
  has_ancestry
end
