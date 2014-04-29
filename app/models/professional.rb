class Professional < ActiveRecord::Base
  validates :professional_encode, presence: true
  validates :professional_name, presence: true
end
