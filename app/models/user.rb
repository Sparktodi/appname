# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  def author?(obj)
    obj.user == self
  end

  def guest?
    false
  end
end
