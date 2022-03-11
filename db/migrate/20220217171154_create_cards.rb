# frozen_string_literal: true

# Migration to create cards table
class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :card_holder_name
      t.string :card_number
      t.string :exp
      t.string :cvv
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
