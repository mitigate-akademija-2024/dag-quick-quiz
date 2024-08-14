class CreateLeaderboardTable < ActiveRecord::Migration[7.1]
  def change
    create_table :total_scores do |t|
      t.integer :score

      t.belongs_to :user, foreign_key: true
      t.belongs_to :quiz, foreign_key: true

      t.timestamps
    end
  end
end
