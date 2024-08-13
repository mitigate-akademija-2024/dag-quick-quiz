class AddCreatedByColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :user_id, :integer
    add_foreign_key :quizzes, :users
  end
end
