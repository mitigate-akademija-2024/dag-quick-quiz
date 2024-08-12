class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]
  before_action :set_question, only: [:destroy, :edit, :update]

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

  def edit
  end

  def update

    puts "==++= #{question_attributes}"
    respond_to do |format|
      if @question.update(question_attributes)
        format.html { redirect_to @question.quiz, notice: "Question updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def start
  end

  def test
  end

  def destroy
    @question.destroy!

    redirect_to quiz_path(@question.quiz), notice: "Question was successfully destroyed!"
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

  def set_question
    @question = Question.find(params[:id])
  end

  def question_attributes
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct, :_destroy])
  end
end
