class Profile < ActiveRecord::Base
  attr_accessible :bio, :birthday, :color, :name, :twitter, :user_id

  belongs_to :user
end
