class UserSubscriptionForm < ApplicationForm
  include ActiveModel::Model

  attr_accessor :email, :preferences

  validates :email, presence: true, email_uniqueness: true, email_quality_score: true
  validates :preferences, presence: true

end
