# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  confirmed_at :datetime
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :preference_linkeables, dependent: :destroy
  has_many :preferences, through: :preference_linkeables

  validates :email, presence: true, uniqueness: true, email_quality_score: true

  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  def confirm!
    update_columns(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  def unconfirmed?
    !confirmed?
  end

  MAILER_FROM_EMAIL = "no-reply@example.com"
  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.subscription(self, confirmation_token).deliver_now
  end
end
