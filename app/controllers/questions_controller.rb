class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]

  def index
  end

  def create 
    @question = @quiz.questions.new(question_attributes)

    if params[:commit] == "add_answer"
      @question.answers.new
      render :new, status: :unprocessable_entity
    else

      if @question.save
      flash.notice = "Question was created."
      redirect_to quiz_url(@quiz)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def start
  end

  def test
  end

  def new
    @question = @quiz.questions.new
    2.times { @question.answers.new }
  end

  def add_answer
    @question = @quiz.questions.new(question_attributes)
    @question.answers.new

    render :new
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_attributes
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct])
  end
end
