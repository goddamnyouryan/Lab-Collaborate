# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

def make_ucsf(user)
  user.update_attributes(:school_id => 7)
end

def make_laboratory(laboratory)
  laboratory.update_attributes(:school_id => 7)
end

@users = User.where("school_id = ?", 2)
@users.each do |user|
  make_ucsf(user)
end

@users = User.where("school_id = ?", 17)
@users.each do |user|
  make_ucsf(user)
end

@users = User.where("school_id = ?", 18)
@users.each do |user|
  make_ucsf(user)
end

@users = User.where("school_id = ?", 20)
@users.each do |user|
  make_ucsf(user)
end

@users = User.where("school_id = ?", 26)
@users.each do |user|
  make_ucsf(user)
end

@laboratory = Laboratory.where("school_id = ?", 2)
@laboratory.each do |laboratory|
  make_laboratory(laboratory)
end

@laboratory = Laboratory.where("school_id = ?", 17)
@laboratory.each do |laboratory|
  make_laboratory(laboratory)
end

@laboratory = Laboratory.where("school_id = ?", 18)
@laboratory.each do |laboratory|
  make_laboratory(laboratory)
end

@laboratory = Laboratory.where("school_id = ?", 20)
@laboratory.each do |laboratory|
  make_laboratory(laboratory)
end

@laboratory = Laboratory.where("school_id = ?", 26)
@laboratory.each do |laboratory|
  make_laboratory(laboratory)
end