class Protocol < ActiveRecord::Base
  belongs_to :laboratory
  
  has_attached_file :attachment,
                    :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => ':id/:style/:basename.:extension', :bucket => "labcollaborate_development"
end
