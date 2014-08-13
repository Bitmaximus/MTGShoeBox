class UsersController < ApplicationController

	def show
		@user =User.find(params[:id])
		@title = @user.name
	end

  def new
		@title = "Sign up"
		@user = User.new
  end

  #df user_params(array)
	  #params[array].require(:user).permit(:name, :email)
  #end
end