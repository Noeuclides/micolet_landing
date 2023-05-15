class UsersController < ApplicationController
  before_action :set_user
  before_action :set_preferences

  def new; end

  def create
    begin
      @user = UserCreationService
                .new(user_params[:email], user_params[:preference_ids])
                .call

      flash[:success] = t('success')
      redirect_to root_path
    rescue UserCreationService::EmailTakenError, UserCreationService::EmailBlankError,
      UserCreationService::EmailInvalidError, UserCreationService::EmptyPreferencesError => e
      flash[:error] = e.message
      redirect_to root_path
    rescue StandardError => e
      STDERR.puts e
      flash[:error] = t('errors.failed')
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(User.model_name.param_key.to_sym).permit(:email, preference_ids: [])
  end

  def set_preferences
    @preferences = Preference.all
  end

  def set_user
    @user = User.new
  end
end
