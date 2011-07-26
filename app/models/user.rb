class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :phone, :address, :school_id, :role, :photo, :info
  
  belongs_to :school
  has_many :whiteboards
  has_many :inventories
  has_many :protocols
  has_one :affiliation
  has_one :laboratory, :through => :affiliation, :conditions => "status = 'accepted'"
  has_one :pending_laboratory, :through => :affiliation, :source => :laboratory, :conditions => "status ='pending'"
  
  has_attached_file :photo, :styles => { :thumb => "90x90#", :main => "180x300>", :tiny => "30x30#" }, 
                            :storage => :s3, 
                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                            :path => ':id/:style',
                            :bucket => "labcollaborate_development"
                            
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  
  validates :email, :presence   => true,
                    :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[edu]+\z/i, 
                    :message => "You must have a .edu email address." },
                    :uniqueness => { :case_sensitive => false }
  
  
  def name
    if self.first_name.nil? || self.last_name.nil?
      self.email
    else
      [self.first_name, self.last_name].join(" ")
    end
  end
  
  def make_admin
    self.update_attributes(:role => "admin")
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if 
      params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
end
