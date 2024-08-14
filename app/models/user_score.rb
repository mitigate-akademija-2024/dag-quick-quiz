class UserScore < ApplicationRecord

    belongs_to :answer
    belongs_to :quiz
    belongs_to :user
end