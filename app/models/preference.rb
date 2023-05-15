# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Preference < ApplicationRecord
  extend Mobility
  translates :name, type: :string
end
