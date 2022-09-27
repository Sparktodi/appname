# frozen_string_literal: true

module Admin
  class QuestionPolicy < ApplicationPolicy
    def index?
      user.admin_role?
    end
  end
end
