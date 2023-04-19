class Roll < ApplicationRecord
    belongs_to :frame
    before_save :evaluate_roll_value, :if => :new_record?

    def handle_strike
      if value == 'X'
        self.numeric_value = 10
        self.pending1 = true
        self.pending2 = true
        self.total = 10
      end
    end
      
    def handle_spare
      if value == '/'
        current_value = 10 - Roll.last.numeric_value
        self.numeric_value = current_value
        self.pending1 = true unless is_last
        self.pending2 = false
        self.total = current_value
      end
    end
      
    # Do nothing on gutter
    #def handle_gutter(roll)
    #end   
      
    def handle_others
      symbols = %w(X / -)
      self.numeric_value = value.to_i if !symbols.include?(value)
      self.total = numeric_value unless is_last
    end

    def evaluate_roll_value
      rules = ["handle_strike", "handle_spare", "handle_others"]  
      rules.each{|rule| send(rule) }
    end         

    def update_pending1(val)
      update(pending1: false, total: total + val)  if pending1
    end
  
    def update_pending2(val)
      update(pending2: false, total: total + val)  if pending2
    end   
end