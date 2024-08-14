class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy check start show_answers]
  before_action :authenticate_user!, only: %i[ new create update destroy check ]
  before_action :authenticate_author, only: %i[ update destroy edit show]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all

    @title = "These are all of the quizzes"
    @description = "Here is a list of all of the quizzes"
  end

  def start
    @title = "Start a quiz"
    @description = "Here you can start a quiz"
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  def show_answers
    @score = @quiz.total_scores.where(user_id: current_user.id).last.score
    @total = 0
    @quiz.questions.each do |question|
      question.answers.each do |answer|
        if answer.correct == true
          @total += 1
        end
      end
    end
  end

  def check
    params.fetch(:answers).each do |question_id, answer|
      user_answers = []
      answer.keys.each do |answer_id|
        @answer = Answer.find(answer_id)
        @user_answer = @answer.user_scores.create(user_answer: !answer[answer_id].to_i.zero?, user_id: current_user.id, username: current_user.username, quiz_id: params.fetch(:id))
        user_answers.append !answer[answer_id].to_i.zero?
      end
      if !user_answers.include?(true)
        flash.now.alert = "At least one answer must be chosen!"
        render :start, status: :unprocessable_entity
        return
      end
    end
    @score = 0
    @quiz.questions.each do |question|
      question.answers.each do |answer|
        if answer.correct == true && answer.user_scores.where(user_id: current_user.id).last.user_answer == true
          @score += 1
        end
      end
    end
    @quiz.total_scores.create(user_id: current_user.id, score: @score)
    redirect_to show_answers_quiz_path(@quiz)
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html do
          flash.notice  = "Quiz successfully created!"
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now.alert = "Something went wrong!"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:title, :description, :user_id)
    end

    def answer_params
      params.require([:answers, :username, :id])
    end

    def authenticate_author
      if current_user != @quiz.user
        redirect_to quizzes_url, alert: "You do not have permissions to edit this quiz!"
      end
    end
end
