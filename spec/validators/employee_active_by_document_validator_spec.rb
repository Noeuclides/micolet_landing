require 'rails_helper'

describe EmailQualityScoreValidator, type: :validator do
  let(:email) { 'test@mail.com' }
  let(:api_client) { instance_double("AbstractApi::Client") }

  subject { User.new email: email }

  context 'when a valid email is passed' do
    before do
      allow(AbstractApi::Client).to receive(:new).and_return(api_client)
      allow(api_client).to receive(:quality_score).and_return(0.8)
    end

    it { is_expected.to be_valid }
  end

  context 'When a wrong formatted email is passed' do
    let(:email) { 'wrong_format' }
    before do
      allow(AbstractApi::Client).to receive(:new).and_return(api_client)
      allow(api_client).to receive(:quality_score).and_return(0.0)
    end

    it 'is invalid' do
      subject.email = email
      subject.valid?
      expect(subject.errors[:email]).to match_array(I18n.t('activerecord.errors.models.user.attributes.email.invalid'))
    end
  end

end