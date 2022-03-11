# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# Migrations to create subscriptions
class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :email, default: '', null: false
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :zip_code
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
# rubocop:enable Metrics/MethodLength
