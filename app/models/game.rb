class Game < ApplicationRecord
    has_many :frames
    def update_score
      frames = self.frames.includes(:rolls)  
      @rolls = []
      @frames.each{|frame| rolls += frame.rolls}
      (0...@rolls.length - 2).each do |i|
        roll = @rolls[i]
        next_roll_value = @rolls[i + 1].numeric_value
        second_next_roll_value = @rolls[i + 2].numeric_value
        roll.total += next_roll_value if roll.pending1
        roll.total += second_next_roll_value if roll.pending2
      end
    end
    
    def calculate_total
      self.update_score 
      self.final_score = @rolls.inject(0){|acc, roll| acc + roll.total}
    end    
end