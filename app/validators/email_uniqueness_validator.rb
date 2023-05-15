# Validates the email by its quality score using AbstractApi Client
class EmailUniquenessValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    return if User.find_by_email(value).nil?

    record.errors.add(
      attribute, :taken, **{ payload: record }
    )
  end
end
