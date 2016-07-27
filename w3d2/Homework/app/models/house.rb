class House < ActiveRecord::Base
  validates :address, presence: true
  has_many :people
end
