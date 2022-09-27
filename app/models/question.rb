# frozen_string_literal: true

class Question < ApplicationRecord
  include AASM
  has_many :answers, dependent: :destroy
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :photo, file_size: { less_than: 1.megabytes }

  aasm do
    state :no_active, initial: true
    state :active
    state :complet

    event :start do
      transitions from: :no_active, to: :active
    end

    event :finish do
      transitions from: :active, to: :complet
    end
  end
end
