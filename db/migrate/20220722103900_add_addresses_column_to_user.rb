class AddAddressesColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :postal_code, :string
    add_column :users, :address_line_one, :string
    add_column :users, :address_line_two, :string
  end
end
