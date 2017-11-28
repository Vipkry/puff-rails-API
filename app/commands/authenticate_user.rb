class AuthenticateUser
	prepend SimpleCommand 
	
	def initialize(reg, password)
		@reg = reg
		@password = password 
	end 

	def call 
	 JsonWebToken.encode(user_id: user.id) if user 
	end 

	private 

		attr_accessor :reg, :password

        def user
            user = User.find_by(reg: reg) 
            if user && user.authenticate(password)
                return user
            else
                errors.add :user_authentication, 'Invalid credentials.' 
                return nil
            end
        end 
end