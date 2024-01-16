class AddCodesToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :sender_code, :string
    add_column :transfers, :receiver_code, :string

    add_index :transfers, :sender_code
    add_index :transfers, :receiver_code
  end
end
