class SessionsController < ApplicationController
  def new
		@title = "Sign In"
  end

	def create
		user = User.verify(params[:session][:email], params[:session][:passwors])
		if user.nil?
			flash.now[:error] = "Invalid Email/Password Combination"
			@title = "Sign In"
			render 'new'
		else
			#handle success
		end
	end

	def destroy

	end
end
