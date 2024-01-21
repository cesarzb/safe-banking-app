class Transfer < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :title, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  # validate :sender_and_receiver_presence
  # validate :receiver_exists

  # private

  # def sender_and_receiver_presence
  #   unless sender_id.present? && receiver_id.present?
  #     errors.add(:base, "Sender and receiver must be present")
  #   end
  # end

  # def receiver_exists
  #   return unless receiver_code.present?

  #   receiver = User.find_by(code: receiver_code)
  #   errors.add(:receiver_code, "Receiver with the provided code does not exist") unless receiver
  # end
end
