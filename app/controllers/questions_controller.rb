class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]

  def index
  end

  def create
    @question = @quiz.questions.new(question_attributes)
    if @question.save
      flash.notice = "Question was created."
      redirect_to quiz_url(@quiz)
    end
  end

  def start
  end

  def test
  end

  def new
    @question = @quiz.questions.new
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_attributes
    params.require(:question).permit(:question_text)
  end
end
