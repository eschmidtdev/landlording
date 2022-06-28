class CreateTenants < ActiveRecord::Migration[6.1]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :email, default: "", null: false
      t.string :phone_number
      t.date :lease_end_date
      t.date :lease_start_date
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
