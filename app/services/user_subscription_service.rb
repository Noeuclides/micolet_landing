class UserSubscriptionService

  class Error < StandardError; end

  def initialize(user_subscription_form)
    @user_subscription_form = user_subscription_form
  end

  def call
    unless @user_subscription_form.valid?
      raise error_instance
    end

    create_user
  end

  private

  def error_instance
    error = @user_subscription_form.errors.first
    error_type = error.type.to_s
    error_attribute = error.attribute.to_s

    UserSubscriptionService::Error.new(I18n.t("activerecord.errors.models.user.attributes.#{error_attribute}.#{error_type}"))
  end

  def create_user
    user = User.create! email: @user_subscription_form.email
    @user_subscription_form.preferences.each do |preference_id|
      PreferenceLinkeable.create! preference_id: preference_id.to_i, user: user
    end

    send_email(user)
  end

  def send_email(user)
    user.send_confirmation_email!
  end
end