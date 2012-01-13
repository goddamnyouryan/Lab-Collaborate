class Protocol < ActiveRecord::Base
  belongs_to :laboratory
  belongs_to :user
  acts_as_taggable
  
  has_attached_file :attachment,
                    :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => ':id/:style/:basename.:extension', :bucket => "labcollaborate_development",
                    :styles => { :tiny => "200x500>", :large => "640x1000>" }
                    
  has_many :likes
end
