class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true, allow_blank: false

    has_many :user_scores
end