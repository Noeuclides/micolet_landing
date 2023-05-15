module SubscriptionHelper
  def subscribe(email: '', check_preference: true)
    visit root_path

    fill_in 'user_email', with: email
    check 'user_preference_ids_1' if check_preference

    sleep(3)

    click_button I18n.t('subscribe')
  end
end
