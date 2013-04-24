class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :professor
  validates_uniqueness_of :email
  validates_presence_of :email , :password , :name
  has_and_belongs_to_many :courses
end
