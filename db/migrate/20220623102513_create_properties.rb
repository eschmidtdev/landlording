class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :city
      t.string :state
      t.string :bed_one
      t.string :bed_two
      t.string :country
      t.string :postal_code
      t.integer :property_type
      t.string :address_line_one
      t.string :address_line_two
      t.string :landlord_contact_name
      t.string :landlord_contact_phone
      t.string :landlord_contact_email
      t.boolean :saved_landlord, default: false
      t.boolean :currently_leased, default: false
      t.boolean :property_for_notice, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
