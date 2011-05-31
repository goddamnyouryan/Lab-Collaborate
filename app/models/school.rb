class School < ActiveRecord::Base
  has_many :laboratories
  has_many :users
end
