class AddPlanColumnToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :plan, :integer, default: 0
  end
end
