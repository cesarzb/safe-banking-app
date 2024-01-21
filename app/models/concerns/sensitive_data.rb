module SensitiveData
  extend ActiveSupport::Concern

  included do
    before_save :encrypt_sensitive_data
  end

  def encrypt_sensitive_data
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.encrypt
    key = Rails.application.credentials.aes_key
    cipher.key = key

    self.encrypted_credit_card = cipher.update(credit_card.to_s) + cipher.final if credit_card.present?
    self.encrypted_personal_id = cipher.update(personal_id.to_s) + cipher.final if personal_id.present?
  end

  def credit_card
    decrypt_attribute(encrypted_credit_card)
  end

  def personal_id
    decrypt_attribute(encrypted_personal_id)
  end

  private

  def decrypt_attribute(encrypted_value)
    return nil if encrypted_value.blank?

    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.decrypt
    cipher.key = 'your_key'

    cipher.update(encrypted_value) + cipher.final
  end
end
