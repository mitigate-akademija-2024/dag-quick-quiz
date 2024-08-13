class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :username, uniqueness: { case_sensitive: false }, allow_blank: false
    validate :validate_username
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

    has_many :user_scores, dependent: :destroy
    has_many :quizzes, dependent: :destroy

    attr_writer :login


    def validate_username
        if User.where(email: username).exists?
            errors.add(:username, :invalid)
        end
    end

    def login
        @login || self.username || self.email
    end

    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if (login = conditions.delete(:login))
          where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        elsif conditions.has_key?(:username) || conditions.has_key?(:email)
          where(conditions.to_h).first
        end
      end
end