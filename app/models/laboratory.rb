class Laboratory < ActiveRecord::Base
  belongs_to :school
  has_many :protocols
  has_many :whiteboards
  
  has_many :affiliations
  has_many :users, :through => :affiliations, :conditions => "status ='accepted'"
  has_many :pending_users, :through => :affiliations, :source => :user, :conditions => "status = 'pending'"
  
  has_many :collaborators, :through => :friends, :source => :friend, :conditions => "status = 'accepted'"
	has_many :pending_collaborators, :through => :friends, :source => :friend, :conditions => "status = 'pending'"
	has_many :requested_collaborators, :through => :friends, :source => :friend, :conditions => "status = 'requested'"
	has_many :friends, :dependent => :destroy
	
	def add_friend(friend, user)
	  @friend1 = Friend.create(:laboratory_id => self.id, :friend_id => friend.id, :user_id => user.id, :status => "requested")
	  @friend2 = Friend.create(:laboratory_id => friend.id, :friend_id => self.id, :user_id => nil, :status => "pending")
	end
	
	def accept_friendship(friend, user)
	  @friend1 = Friend.find_by_laboratory_id_and_friend_id(self.id, friend.id)
	  @friend2 = Friend.find_by_laboratory_id_and_friend_id(friend.id, self.id)
	  @friend1.update_attributes(:status => "accepted", :user_id => user.id)
	  @friend2.update_attributes(:status => "accepted")
  end
  
  def decline_friendship(friend)
    @friend1 = Friend.find_by_laboratory_id_and_friend_id(self.id, friend.id)
	  @friend2 = Friend.find_by_laboratory_id_and_friend_id(friend.id, self.id)
	  @friend1.destroy
	  @friend2.destroy
  end
end
