class AddPasswordLettersToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :variation_number, :integer, default: 0
    add_column :users, :password_letter_1_digest, :string, limit: 1
    add_column :users, :password_letter_2_digest, :string, limit: 1
    add_column :users, :password_letter_3_digest, :string, limit: 1
    add_column :users, :password_letter_4_digest, :string, limit: 1
    add_column :users, :password_letter_5_digest, :string, limit: 1
    add_column :users, :password_letter_6_digest, :string, limit: 1
    add_column :users, :password_letter_7_digest, :string, limit: 1
    add_column :users, :password_letter_8_digest, :string, limit: 1
    add_column :users, :password_letter_9_digest, :string, limit: 1
    add_column :users, :password_letter_10_digest, :string, limit: 1
    add_column :users, :password_letter_11_digest, :string, limit: 1
    add_column :users, :password_letter_12_digest, :string, limit: 1
    add_column :users, :password_letter_13_digest, :string, limit: 1
    add_column :users, :password_letter_14_digest, :string, limit: 1
    add_column :users, :password_letter_15_digest, :string, limit: 1
    add_column :users, :password_letter_16_digest, :string, limit: 1
  end
end
