# == Schema Information
#
# Table name: preference_linkeables
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  preference_id :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_preference_linkeables_on_preference_id  (preference_id)
#  index_preference_linkeables_on_user_id        (user_id)
#
# Foreign Keys
#
#  preference_id  (preference_id => preferences.id)
#  user_id        (user_id => users.id)
#
class PreferenceLinkeable < ApplicationRecord
  belongs_to :user
  belongs_to :preference
end
