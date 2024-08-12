class UserScore < ApplicationRecord

    validates :username, presence: true

    belongs_to :answer
end