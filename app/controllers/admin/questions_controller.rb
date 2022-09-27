# frozen_string_literal: true

module Admin
  class QuestionsController < ApplicationController
    before_action :authorize_question!, only: :index
    before_action :set_question, only: %i[start finish]
    after_action :verify_authorized, only: :index

    def index
      @questions = Question.order(updated_at: :desc).page params[:page]
    end

    def start
      redirect_to admin_questions_path if @question.start!
      flash[:success] = t('admin.update')
    end

    def finish
      redirect_to admin_questions_path if @question.finish!
      flash[:success] = t('admin.update')
    end

    private

    def set_question
      @question = Question.find(params[:id])
    end

    def authorize_question!
      authorize([:admin, (@question || Question)])
    end
  end
end
