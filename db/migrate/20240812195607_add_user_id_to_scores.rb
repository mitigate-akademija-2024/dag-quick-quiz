class AddUserIdToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :user_scores, :user_id, :integer
    add_foreign_key :user_scores, :users
  end
end
