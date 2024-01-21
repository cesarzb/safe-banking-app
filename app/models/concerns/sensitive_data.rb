module SensitiveData
  extend ActiveSupport::Concern
  def credit_card
    encrypted_credit_card
  end

  def personal_id
    encrypted_personal_id
  end
end
