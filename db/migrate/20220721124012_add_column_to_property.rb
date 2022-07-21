class AddColumnToProperty < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :tenant_notice_city, :string
    add_column :properties, :tenant_notice_state, :string
    add_column :properties, :tenant_notice_postal_code, :string
    add_column :properties, :tenant_notice_street_line_one, :string
    add_column :properties, :tenant_notice_street_line_two, :string
  end
end
