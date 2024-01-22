class AddReceiverNameToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :receiver_name, :string, null: false
  end
end
