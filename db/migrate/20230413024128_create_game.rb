# frozen_string_literal: true

class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :final_score, default: 0
      t.timestamps
    end
  end
end
