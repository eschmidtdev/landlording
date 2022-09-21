class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.text :access_token, default: "", null: false

      t.timestamps
    end
  end
end
