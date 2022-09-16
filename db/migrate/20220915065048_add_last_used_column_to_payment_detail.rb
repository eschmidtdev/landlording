class AddLastUsedColumnToPaymentDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_details, :last_used, :datetime
  end
end
