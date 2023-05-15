require 'rails_helper'

RSpec.feature 'User subscription', type: :feature do
  let!(:preference) { create(:preference) }
  let(:email) { 'test@mail.com' }

  context 'when an employee is subscribed succesfully' do
    include_context 'stub_abstract_api_shared_context'

    it 'is created a user and delivers an email' do
      subscribe(email: email)

      expect(page).to have_content I18n.t('success')
      expect(User.count).to eq(1)
      expect(User.first.email).to eq(email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  context 'when an user does not input an email' do
    include_context 'stub_abstract_api_shared_context', 0.0

    let(:email) { '' }

    it_behaves_like 'unsuccessful subscription shared example', I18n.t('activerecord.errors.models.user.attributes.email.blank')
  end

  context 'when an user does not input a valid email' do
    include_context 'stub_abstract_api_shared_context', 0.0

    let(:email) { 'wrong_format' }

    it_behaves_like 'unsuccessful subscription shared example', I18n.t('activerecord.errors.models.user.attributes.email.invalid')
  end

  context 'when a user already exists' do
    include_context 'stub_abstract_api_shared_context', 0.95

    it 'displays taken email error' do
      create(:user, email: email)
      subscribe(email: email)

      expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.email.taken')
    end
  end

  context 'when something goes wrong' do
    let(:api_client) { instance_double("AbstractApi::Client") }

    before do
      allow(AbstractApi::Client).to receive(:new).and_return(api_client)
      allow(api_client).to receive(:quality_score).and_raise(AbstractApi::Client::AbstractApiError)
    end

    it 'displays failed error' do
      subscribe(email: email)

      expect(page).to have_content I18n.t('errors.failed')
    end
  end

  context 'when no preference is selected' do
    include_context 'stub_abstract_api_shared_context'

    it 'displays preferences error' do
      subscribe(email: email, check_preference: false)
      expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.preferences.blank')
    end
  end


end