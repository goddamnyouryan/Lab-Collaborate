class School < ActiveRecord::Base
  has_many :laboratories, :dependent => :destroy
  has_many :users
  
  def autocomplete
    "#{self.name} (#{self.laboratories.count} labs)"
  end
end
