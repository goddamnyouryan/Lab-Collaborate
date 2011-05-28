class School < ActiveRecord::Base
  has_many :laboritories
  has_many :users
end
