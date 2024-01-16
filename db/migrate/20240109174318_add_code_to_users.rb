class AddCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :code, :string
    add_index :users, :code, unique: true
  end
end
