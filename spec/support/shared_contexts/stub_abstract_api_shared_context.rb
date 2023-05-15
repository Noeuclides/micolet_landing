RSpec.shared_context "stub_abstract_api_shared_context" do |score = 0.8|
  let(:api_client) { instance_double("AbstractApi::Client") }

  before do
    allow(AbstractApi::Client).to receive(:new).and_return(api_client)
    allow(api_client).to receive(:quality_score).and_return(score)
  end
end