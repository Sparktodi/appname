# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable, :lockable, :omniauthable, omniauth_providers: [:facebook]

  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :password, confirmation: true, allow_blank: true
  validates :email, presence: true
  validates :role, presence: true

  def author?(obj)
    obj.user == self
  end

  def guest?
    false
  end
end
