# frozen_string_literal: true

class HomeController < ApplicationController
  def home; end

  def profile
    @questions = current_user.questions.order(updated_at: :desc).page params[:page]
  end
end
