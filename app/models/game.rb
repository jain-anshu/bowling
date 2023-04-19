# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :frames
  def update_score
    @frames = frames.includes(:rolls)
    @rolls = @frames.inject([]) { |acc, frame| acc + frame.rolls }
    (0...@rolls.length - 2).each do |i|
      roll = @rolls[i]
      next_roll_value = @rolls[i + 1].numeric_value
      second_next_roll_value = @rolls[i + 2].numeric_value
      roll.update_pending1(next_roll_value)
      roll.update_pending2(second_next_roll_value)
    end
  end

  def calculate_total
    update_score
    final_score = @rolls.inject(0) { |acc, roll| acc + roll.total }
    update(final_score:)
  end
end
