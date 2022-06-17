class CreatePaymentDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_line_one
      t.string :address_line_two
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country
      t.string :card_number
      t.string :exp
      t.string :cvc
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
