# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@users = User.all
@users.each do |user|
  @name = [user.first_name, user.last_name].join(" ")
  user.update_attributes(:fullname => @name)
end
