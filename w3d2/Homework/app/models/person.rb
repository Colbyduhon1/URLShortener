class Person < ActiveRecord::Base
  validates :name, :house, presence: true
  belongs_to :house
end
