class Answer < ApplicationRecord

    validates :answer_text, presence: true, on: :is_present

    belongs_to :question

    has_many :user_score
end