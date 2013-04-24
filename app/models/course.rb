class Course < ActiveRecord::Base
  attr_accessible :availability, :course_description, :course_name, :prerequiste
  has_and_belongs_to_many :user
end
