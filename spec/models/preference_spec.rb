# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Preference, type: :model do
  describe "translations" do
    let(:preference_en) { "Women's Fashion" }
    let(:preference_es) { "Moda Mujeres" }

    it "allows the name to be translated" do
      preference = Preference.new

      I18n.with_locale(:en) do
        preference.name = preference_en
        expect(preference.name).to eq(preference_en)
      end

      I18n.with_locale(:es) do
        preference.name = preference_es
        expect(preference.name).to eq(preference_es)
      end
    end
  end
end
