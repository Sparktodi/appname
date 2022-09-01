# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :photo, file_size: { less_than: 1.megabytes }
end
