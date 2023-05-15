require 'rails_helper'

RSpec.describe AbstractApi::Client do
  let(:api_key) { '1234' }
  let(:email) { 'test@example.com' }
  let(:client) { described_class.new(api_key: api_key, email: email) }

  describe '#quality_score' do
    context 'when email is valid' do
      let(:response_body) { { 'quality_score' => '0.8' } }

      it 'returns the quality score as a float' do
        allow(client).to receive(:api_response).and_return([200, {}, response_body])
        expect(client.quality_score).to eq(0.8)
      end
    end

    context 'when email is not present' do
      let(:email) { '' }

      it 'returns 0.0' do
        expect(client.quality_score).to eq(0.0)
      end
    end

    context 'when API call fails' do
      before do
        allow(client).to receive(:api_response).and_return([500, {}, ''])
      end

      it 'raises an AbstractApiError' do
        expect { client.quality_score }.to raise_error(AbstractApi::Client::AbstractApiError)
      end
    end
  end
end
