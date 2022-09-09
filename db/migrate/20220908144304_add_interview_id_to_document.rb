class AddInterviewIdToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :interview_id, :string
  end
end
