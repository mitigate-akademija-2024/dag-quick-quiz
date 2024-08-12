class UserScore < ApplicationRecord

    validates :username, presence: true

    belongs_to :answer
    belongs_to :quiz
    belongs_to :user
end