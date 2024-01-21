module PasswordLetters
  extend ActiveSupport::Concern

  included do
    before_save :set_password_letters
    has_secure_password :password_letter_1, validations: false
    has_secure_password :password_letter_2, validations: false
    has_secure_password :password_letter_3, validations: false
    has_secure_password :password_letter_4, validations: false
    has_secure_password :password_letter_5, validations: false
    has_secure_password :password_letter_6, validations: false
    has_secure_password :password_letter_7, validations: false
    has_secure_password :password_letter_8, validations: false
    has_secure_password :password_letter_9, validations: false
    has_secure_password :password_letter_10, validations: false
    has_secure_password :password_letter_11, validations: false
    has_secure_password :password_letter_12, validations: false
    has_secure_password :password_letter_13, validations: false
    has_secure_password :password_letter_14, validations: false
    has_secure_password :password_letter_15, validations: false
    has_secure_password :password_letter_16, validations: false
  end

  def set_password_letters
    if password.present?
      self.password_letter_1 = password[0]
      self.password_letter_2 = password[1]
      self.password_letter_3 = password[2]
      self.password_letter_4 = password[3]
      self.password_letter_5 = password[4]
      self.password_letter_6 = password[5]
      self.password_letter_7 = password[6]
      self.password_letter_8 = password[7]
      self.password_letter_9 = password[8]
      self.password_letter_10 = password[9]
      self.password_letter_11 = password[10]
      self.password_letter_12 = password[11]
      self.password_letter_13 = password[12] || '-'
      self.password_letter_14 = password[13] || '-'
      self.password_letter_15 = password[14] || '-'
      self.password_letter_16 = password[15] || '-'
    end
  end
end
