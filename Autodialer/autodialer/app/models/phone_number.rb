class PhoneNumber < ApplicationRecord
  validates :number, presence: true, uniqueness: true
end