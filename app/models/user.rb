class User < ApplicationRecord
    
    has_secure_password
    
    before_validation :check_reg
    
    validates_presence_of :reg
    
    # OK tested
    def check_reg
      if !self.reg.scan(/\D/).empty?
        self.errors.add(:reg, "Reg should be composed by digits only.") 
      end
    end
end
