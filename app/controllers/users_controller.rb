class UsersController < ApplicationController
  before_action :set_user_suscription_form
  before_action :set_preferences

  def new; end

  def create
    begin
      @user_subscription = UserSubscriptionForm.new user_subscription_form_params
      UserSubscriptionService.new(@user_subscription).call

      flash[:success] = t('success')
      redirect_to root_path
    rescue UserSubscriptionService::Error => e
      respond_to do |format|
        format.turbo_stream { render :'users/create/invalid', status: :unprocessable_entity, locals: { error: e.message } }
      end
    rescue StandardError => e
      STDERR.puts e
      respond_to do |format|
        format.turbo_stream { render :'users/create/invalid', status: :unprocessable_entity, locals: { error:  t('errors.failed') } }
      end
    end
  end

  private

  def user_subscription_form_params
    params.require(UserSubscriptionForm.model_name.param_key.to_sym).permit(:email, preferences: [])
  end

  def set_preferences
    @preferences = Preference.all
  end

  def set_user_suscription_form
    @user_subscription = UserSubscriptionForm.new
  end
end
