require 'spec_helper'

describe UsersController do
	render_views

	describe "GET 'show'" do
		before(:each) do
			@user = FactoryGirl.create(:user)
		end

		after(:each) do
			@user.destroy
		end

		it "Should be succesful" do
			get :show, :id => @user.id
			response.should be_success
		end

		it "Find the right user" do
			get :show, :id => @user.id
			assigns(:user).should == @user
		end

		it "Should have the right title" do
			get :show, :id => @user.id
			response.should have_selector("title", :content => @user.name)
		end

		it "Should show the user name" do
			get :show, :id => @user.id
			response.should have_selector("h1", :content => @user.name)
		end

		it "Should show the users profile image" do
			get :show, :id => @user.id
			response.should have_selector("h1>img", :class => "gravatar")
		end
	end

	describe "GET 'new'" do

		it "should be succesful" do
			get :new
			response.should be_success
		end

		it "Should have the right title" do
			get :new
			response.should have_selector('title', :content => 'Sign up')
		end
	end

	describe "POST 'create'" do
		describe 'Failure' do
			before(:each) do
				@attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
			end
			it "Should have the right title" do
				post :create, :user => @attr
				response.should have_selector('title', :content => 'Sign Up')
			end

			it "should render the 'new' page" do
				post :create, :user => @attr
				response.should render_template('new')
			end

			it "should not create a user" do
				lambda do
					post :create, :user => @attr
				end.should_not change(User, :count)
			end
		end
		describe "Success" do
			before(:each) do
				@attr = { :name => "New User", :email => "user@example.com", :password => "foobar",
				          :password_confirmation => "foobar"}
			end

			it "should create a user" do
				lambda do
					post :create, :user => @attr
				end.should change(User, :count).by(1)
			end

			it "should redirect to the user show page" do
				post :create, :user => @attr
				response.should redirect_to(user_path(assigns(:user)))
			end

			it "should have a one time welcome message" do
				post :create, :user => @attr
				flash[:success].should =~ /welcome to mtg shoebox new user/i
			end
			it "should sign the user in" do
				post :create, :user => @attr
				controller.should be_signed_in
			end
		end
	end
end
