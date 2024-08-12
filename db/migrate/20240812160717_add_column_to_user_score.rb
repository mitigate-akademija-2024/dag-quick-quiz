class AddColumnToUserScore < ActiveRecord::Migration[7.1]
  def change
    add_column :user_scores, :quiz_id, :integer
    add_foreign_key :user_scores, :quizzes
  end
end
