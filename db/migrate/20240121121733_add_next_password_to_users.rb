class AddNextPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :next_password, :string
  end
end
