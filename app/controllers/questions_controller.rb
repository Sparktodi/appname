# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]
  before_action :authorize_question!
  after_action :verify_authorized

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page params[:page]
  end

  def destroy
    @question.destroy
    flash[:success] = t('question.destroy')
    if current_user.role == 'admin'
      redirect_to admin_questions_path
    else
      redirect_to my_profile_path
    end
  end

  def update
    if @question.update question_params
      flash[:success] = t('question.update')
      redirect_to question_path
    else
      render :new
    end
  end

  def edit; end

  def index
    @q = Question.where(aasm_state: 'active').or(Question.where(aasm_state: 'complet')).order(created_at: :desc).ransack(params[:q])
    @questions = @q.result(distinct: true).page params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build question_params
    if @question.save
      flash[:success] = t('question.create')
      redirect_to my_profile_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :photo, :photo_cache, :remove_photo)
  end

  def set_question!
    @question = Question.find params[:id]
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
