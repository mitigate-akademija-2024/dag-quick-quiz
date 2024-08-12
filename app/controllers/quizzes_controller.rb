class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy check start]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all

    @title = "These are all of the quizzes"
    @description = "Here is a list of all of the quizzes"
  end

  def start
    @title = "Start a quiz"
    @description = "Here you can start a quiz"
    if defined? @quiz
      @user_answers = @quiz.user_answers
    else
      set_quiz
    end
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  def check
    puts "params: #{answer_params}" 

    answer_params[0].each do |question_id, answer|
      puts "answer: #{answer}"
      answer.keys.each do |answer_id|
        @answer = Answer.find(answer_id)
        correct_answer = @answer.correct
        puts "user: #{answer[answer_id]}, correct: #{correct_answer}"
        @user_answer = @answer.user_score.create(user_answer: !answer[answer_id].to_i.zero?, username: answer_params[1])
        if !answer[answer_id].to_i.zero? == correct_answer
          puts "answer_id: #{answer_id}"        
        end
      end
    end

    render :start
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
      params.require(:quiz).permit(:title, :description)
    end

    def answer_params
      params.require([:answers, :username])
    end
end
