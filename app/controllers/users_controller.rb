class UsersController < ApplicationController

    def my_quizzes
        @quizzes = Quiz.where(user_id: current_user).all
    end
end