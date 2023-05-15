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
require 'rails_helper'

RSpec.describe User, type: :model do
  include_context 'stub_abstract_api_shared_context'

  describe "fields" do
    it { should have_db_column(:email).of_type(:string) }
  end

  describe "Associations" do
    it { should have_many(:preference_linkeables).class_name(::PreferenceLinkeable.name).dependent(:destroy) }
    it { should have_many(:preferences).through(:preference_linkeables).class_name(::Preference.name) }
  end

  describe "validations" do
    subject { build(described_class.model_name.singular.to_sym) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe "methods" do
    let(:user) { create(:user) }

    describe "#confirm!" do
      it "updates the confirmed_at attribute" do
        expect { user.confirm! }.to change { user.confirmed_at }.from(nil).to(Time)
      end
    end

    describe "#confirmed?" do
      context "when the confirmed_at attribute is present" do
        it "returns true" do
          user.confirmed_at = Time.current
          expect(user.confirmed?).to be_truthy
        end
      end

      context "when the confirmed_at attribute is not present" do
        it "returns false" do
          user.confirmed_at = nil
          expect(user.confirmed?).to be_falsy
        end
      end
    end

    describe "#generate_confirmation_token" do
      it "returns a signed ID with a 10-minute expiration time for email confirmation" do
        token = user.generate_confirmation_token

        expect(token).to be_a(String)
        expect(token).not_to be_empty

        expect(User.find_signed token, purpose: :confirm_email).to eq(user)

        travel (User::CONFIRMATION_TOKEN_EXPIRATION + 1.minute)
        expect(User.find_signed token, purpose: :confirm_email).to eq(nil)
      end
    end

    describe "#unconfirmed?" do
      context "when the confirmed_at attribute is not present" do
        it "returns true" do
          user.confirmed_at = nil
          expect(user.unconfirmed?).to be_truthy
        end
      end

      context "when the confirmed_at attribute is present" do
        it "returns false" do
          user.confirmed_at = Time.current
          expect(user.unconfirmed?).to be_falsy
        end
      end
    end

    describe "#send_confirmation_email!" do
      it "sends a confirmation email to the user" do
        expect { user.send_confirmation_email! }.to change { ActionMailer::Base.deliveries.count }.by(1)
        mail = ActionMailer::Base.deliveries.last
        expect(mail.from).to eq([User::MAILER_FROM_EMAIL])
        expect(mail.to).to eq([user.email])
        expect(mail.subject).to eq(I18n.t("email_message"))
      end
    end
  end
end
