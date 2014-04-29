class Academy < ActiveRecord::Base
  validates :academy_encode, presence: true
  validates :academy_name, presence: true
end
