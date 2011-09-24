class Event < ActiveRecord::Base
  belongs_to :laboratory
  serialize :data, Hash
end
