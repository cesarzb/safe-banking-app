class Transfer < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :title, presence: true
  validates :amount, presence: true
end
