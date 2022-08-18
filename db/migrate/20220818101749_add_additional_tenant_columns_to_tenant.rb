class AddAdditionalTenantColumnsToTenant < ActiveRecord::Migration[6.1]
  def change
    add_column :tenants, :additional_tenant_name, :string
    add_column :tenants, :additional_tenant_phone, :string
    add_column :tenants, :additional_tenant_email, :string
  end
end
