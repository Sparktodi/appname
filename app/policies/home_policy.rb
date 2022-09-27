# frozen_string_literal: true

class HomePolicy < ApplicationPolicy
  def home
    true
  end

  def profile
    !user.guest?
  end
end
