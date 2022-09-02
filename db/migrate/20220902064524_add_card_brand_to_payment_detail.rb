class AddCardBrandToPaymentDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_details, :brand, :string
  end
end
