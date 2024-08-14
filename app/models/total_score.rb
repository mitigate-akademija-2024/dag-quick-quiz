class TotalScore < ApplicationRecord
    default_scope { order(score: :desc) }
    belongs_to :quiz
    belongs_to :user
end