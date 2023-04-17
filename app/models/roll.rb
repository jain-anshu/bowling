class Roll < ApplicationRecord
    belongs_to :frame
    before_save :evaluate_roll_value

    def handle_strike
        if self.value == 'X'
          self.numeric_value = 10
          self.pending1 = true
          self.pending2 = true
          self.total = 10
        end
    end
      
    def handle_spare
        if self.value == '/'
        current_value = 10 - Roll.last.numeric_value
        self.numeric_value = current_value
        self.pending1 = true unless self.is_last
        self.pending2 = false
        self.total = current_value
        end
    end
      
    # Do nothing on gutter
    #def handle_gutter(roll)
    #end   
      
    def handle_others
        symbols = %w[X / -]
        self.numeric_value = value.to_i if !symbols.include?(self.value)
        @total = self.numeric_value unless self.is_last
    end

    def evaluate_roll_value
      rules = ["handle_strike", "handle_spare", "handle_others"]  
      rules.each do |rule|
        self.send(rule)
      end
    end 

    def update_pending1(val)
      total = self.total + val   
      self.update(pending1: false, total: total)  if self.pending1
    end
    
    def update_pending2(val)
      total = self.total + val   
      self.update(pending2: false, total: total)  if self.pending2
    end   

end