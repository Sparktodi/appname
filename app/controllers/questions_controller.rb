class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]


  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page params[:page]
  end

  def destroy
    @question.destroy
    flash[:success] = "Questions delete"
    redirect_to questions_path
  end

  def update
    if @question.update question_params
      flash[:success] = "Questions update"
      redirect_to question_path
    else
      render :new
    end
  end


  def edit
  end

  def index
    @questions = Question.order(created_at: :desc).page params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Questions create"
      redirect_to questions_path
    else
      render :new
    end
  end


  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end
 