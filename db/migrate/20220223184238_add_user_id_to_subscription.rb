# frozen_string_literal: true

class AddUserIdToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :user_id, :bigint, null: false
  end
end
