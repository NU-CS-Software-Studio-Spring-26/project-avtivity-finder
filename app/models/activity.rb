class Activity < ApplicationRecord
  validates :title, presence: true
  validates :city, presence: true
end
