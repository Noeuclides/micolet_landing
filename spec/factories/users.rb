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
FactoryBot.define do
  factory :user do
    email { "user@example.com" }
  end
end
