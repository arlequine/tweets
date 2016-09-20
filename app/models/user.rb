class User < ActiveRecord::Base
  

	validates :email, presence: true, uniqueness: true



	def self.autenticate(email, password)
		user = User.find_by(email:email)

		if user.password == password
			user
		else
			nil
		end
	end


end
