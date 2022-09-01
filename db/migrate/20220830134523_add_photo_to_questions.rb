# frozen_string_literal: true

class AddPhotoToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :photo, :string
  end
end
