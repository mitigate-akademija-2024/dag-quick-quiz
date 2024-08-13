class Answer < ApplicationRecord

    validates :answer_text, presence: true

    belongs_to :question

    has_many :user_scores, dependent: :destroy
end