class UserInput < ApplicationRecord
  belongs_to :user, optional: true 
  validates :data_usage, :call_time, :sms_usage, presence: true
  # validates :data_usage, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :call_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :sms_usage, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
