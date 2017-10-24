class Rating < ApplicationRecord
    
    belongs_to :user
    belongs_to :param
    belongs_to :teacher
    
end
