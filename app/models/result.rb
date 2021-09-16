class Result < ApplicationRecord
    belongs_to:user ,optional: true
    
    def user
       return User.find_by(id: self.user_id)
    end
end
