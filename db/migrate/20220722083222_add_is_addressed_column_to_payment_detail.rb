class AddIsAddressedColumnToPaymentDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_details, :is_address, :boolean, default: false
  end
end
