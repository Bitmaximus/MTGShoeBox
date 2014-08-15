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

	describe "GET 'edit'" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
		end
		it "should be succesful" do
			get :edit, :id => @user
			response.should be_success
		end
		it"should have the right title" do
			get :edit, :id => @user
			response.should have_selector('title', :content => "Edit User")
		end
		it "should display a gravatar and a link to change it" do
			get :edit, :id => @user
			response.should have_selector('a', :href => 'http://gravatar.com/emails',
			                              :content => 'Change')
		end
	end
	describe "PUT 'update'" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
		end
		describe "failure" do
			before(:each) do
				@attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
			end
			it "should render the edit page" do
				put :update, :id => @user, :user => @attr
				response.should render_template('edit')
			end
			it "should have the right title" do
				put :update, :id => @user, :user => @attr
				response.should have_selector('title', :content => "Edit User")
			end
		end
		describe "success" do
			before(:each) do
				@attr = { :name => "New Name", :email => "user@new.com", :password => "barbaz", :password_confirmation => "barbaz" }
			end
			it "should change the users attributes" do
				put :update, :id => @user, :user => @attr
				user = assigns(:user)
				@user.reload
				@user.name.should == user.name
				@user.email.should == user.email
				#@user.password.should == user.password
			end
			it "should have a flash message" do
				put :update, :id => @user, :user => @attr
				flash[:success].should =~ /updated/i
			end
		end
	end
end
