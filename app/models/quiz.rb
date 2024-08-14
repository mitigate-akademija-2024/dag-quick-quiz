class Quiz < ApplicationRecord

    validates :title, presence: true, uniqueness: true

    before_validation :normalize_title

    before_save :normalize_description

    belongs_to :user
    has_many :questions, dependent: :destroy
    has_many :user_scores, dependent: :destroy
    has_many :total_scores, dependent: :destroy

    require 'csv'

    def to_csv
        scores = self.total_scores.joins(:user).select('total_scores.*, users.username').limit(10)
        columns = ['username', 'score', 'created_at']
        CSV.generate do |csv|
            csv << columns
            scores.each do |score|
                csv << score.attributes.values_at(*columns)
            end
        end
    end

    protected

    def normalize_title
        Rails.logger.info("Quiz #normalize_title called")
        self.title = title.to_s.squish.downcase.titleize
    end

    def normalize_description
        Rails.logger.info("Quiz #normalize_description called")
        self.description = description.to_s.squish
    end

end