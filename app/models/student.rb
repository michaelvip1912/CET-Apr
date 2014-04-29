class Student < ActiveRecord::Base
  validates :student_no, presence: true
  validates :name, presence: true
  validates :grade, presence: true
  validates :id_number, presence: true
  validates :academy_encode, presence: true
  validates :professional_encode, presence: true
  validates :gender, presence: true
end
