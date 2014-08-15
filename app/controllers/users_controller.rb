class UsersController < ApplicationController

	def show
		@user =User.find(params[:id])
		@title = @user.name
	end

	def new
		@title = "Sign up"
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			redirect_to @user, :flash => { :success => "Welcome to MTG ShoeBox #{@user.name}!"}
		else
			@title = "Sign Up"
			render 'new'
		end

	end

	def edit
	@user = User.find(params[:id])
	@title = 'Edit User'
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to @user, :flash => { :success => "Your profile was updated successfully!"}
		else
			@title = "Edit User"
		render 'edit'
		end
	end
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end