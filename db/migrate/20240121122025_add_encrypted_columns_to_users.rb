class AddEncryptedColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :encrypted_credit_card, :text
    add_column :users, :encrypted_personal_id, :text
  end
end
