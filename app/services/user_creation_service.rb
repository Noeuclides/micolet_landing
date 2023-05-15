class UserCreationService

  class EmailTakenError < StandardError; end
  class EmailBlankError < StandardError; end

  class EmailInvalidError < StandardError; end

  class EmptyPreferencesError < StandardError; end

  def initialize(email, preference_ids)
    @email = email
    @preference_ids = preference_ids
  end

  def call
    user = User.new email: @email

    unless user.valid?
      error = user.errors.first
      error_type = error.type.to_s
      error_attribute = error.attribute.to_s
      klass = "UserCreationService::Email#{error_type.camelize}Error".safe_constantize
      raise klass.new(I18n.t("activerecord.errors.models.user.attributes.#{error_attribute}.#{error_type}"))
    end

    if @preference_ids.nil?
      raise EmptyPreferencesError.new(I18n.t('errors.preferences.empty'))
    end

    user.save!
    @preference_ids.each do |preference_id|
      PreferenceLinkeable.create! preference_id: preference_id.to_i, user: user
    end

    user.send_confirmation_email!
  end
end