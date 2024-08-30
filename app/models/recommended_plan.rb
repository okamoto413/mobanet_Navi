class RecommendedPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  validates :reason, presence: true
end
