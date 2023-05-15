module SubscriptionHelper
  def subscribe(email: '', check_preference: true)
    visit root_path

    fill_in 'user_subscription_form_email', with: email
    check 'user_subscription_form_preferences_1' if check_preference

    click_button I18n.t('subscribe')
  end
end
