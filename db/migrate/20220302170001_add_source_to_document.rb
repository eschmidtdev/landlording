# frozen_string_literal: true

# Migrations to add column source in documents table
class AddSourceToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :source, :string
  end
end
