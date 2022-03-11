# frozen_string_literal: true

# Migration to add outh column into users table
class AddOuthColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :google_token, :string
    add_column :users, :google_refresh_token, :string
  end
end
