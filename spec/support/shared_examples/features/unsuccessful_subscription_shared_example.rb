shared_examples 'unsuccessful subscription shared example' do |error|
  it 'creates a user and delivers an email' do
    subscribe(email: email)

    expect(page).to have_content error

    expect(User.count).to eq(0)
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end