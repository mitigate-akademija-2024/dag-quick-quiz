class CreateScoreTable < ActiveRecord::Migration[7.1]
  def change
    create_table :user_scores do |t|
      t.belongs_to :answer, foreign_key: true
      
      t.string :username, null: false
      t.boolean :user_answer, null: false, default: false

      t.timestamps
    end
  end
end
