# frozen_string_literal: true

class AddAasmStateToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :aasm_state, :string
  end
end
