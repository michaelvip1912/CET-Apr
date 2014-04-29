class CourseTotal < ActiveRecord::Base
  validates :course_encode, presence: true
  validates :course_name, presence: true
end
