# frozen_string_literal: true

# Migrations to add user references into subscriptions table
class AddUserIdToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :user_id, :bigint, null: false
  end
end
