class CallLog < ApplicationRecord
  validates :phone_number, presence: true
end
