class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :phone, :address, :school_id
  
  belongs_to :school
  has_many :whiteboards
  has_one :affiliation
  has_one :laboratory, :through => :affiliation, :conditions => "status = 'accepted'"
  has_one :pending_laboratory, :through => :affiliation, :source => :laboratory, :conditions => "status ='pending'"
  
  def name
    [self.first_name, self.last_name].join(" ")
  end
end
