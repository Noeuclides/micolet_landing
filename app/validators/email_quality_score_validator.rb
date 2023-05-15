# Validates the email by its quality score using AbstractApi Client
class EmailQualityScoreValidator < ActiveModel::EachValidator
  MINIMUM_EMAIL_SCORE_ACCEPTED = 0.7

  def validate_each(record, attribute, value)
    abstract_api_client = AbstractApi::Client.new(email: value)

    return if abstract_api_client.quality_score > MINIMUM_EMAIL_SCORE_ACCEPTED

    record.errors.add(
      attribute, :invalid, **{ payload: record }
    )
  end
end
