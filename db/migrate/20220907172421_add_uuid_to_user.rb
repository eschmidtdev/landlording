class AddUuidToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uuid, :string, default: "", null: false
  end
end
