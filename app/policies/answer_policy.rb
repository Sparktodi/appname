# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    !user.guest?
  end

  def update?
    user.admin_role? || user.moderator_role? || user.author?(record)
  end

  def destroy?
    user.admin_role? || user.author?(record)
  end

  def show?
    true
  end
end
