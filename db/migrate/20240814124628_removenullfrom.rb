class Removenullfrom < ActiveRecord::Migration[7.1]
  def change
    change_column_null :user_scores, :username, true
  end
end
