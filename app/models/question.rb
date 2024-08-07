class Question < ApplicationRecord
    validates :title, :description, presence: true

    belongs_to :quiz
end