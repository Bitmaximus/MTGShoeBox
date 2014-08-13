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


end
