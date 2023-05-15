# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :preference do
    name { "test preference" }
  end
end
