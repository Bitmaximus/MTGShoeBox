# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'


describe User do

	before(:each) do
		@attr = { :name => "Eae Usr", :email => "rzczcz@e.com", :password => "foobar", :password_confirmation => "foobar"}
	end

  it "should create a new instance given a valid atrribute" do
	user = User.new(@attr)
	user.should be_valid
  end
	it "should require a name" do
		no_name_user = User.new(@attr.merge(:name => "" ))
		no_name_user.should_not be_valid
	end
  it "should require an email address" do
	  no_email_user = User.new(@attr.merge(:email => ""))
	  no_email_user.should_not be_valid
  end
	it "should reject names that are too long" do
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:name => long_name))
		long_name_user.should_not be_valid
	end
	it "should accept valid email addresses" do
		addresses = %w[foor@bar.ca baz.quox@foo.bar.com BAZQUOX@FUBAR.net]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
		end
	it "should reject invalid email addresses" do
		addresses = %w[foor@bar,ca user_at_quox.com BAZQUOX@FUBAR. BAZQUOX@FUBAR]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
			end
	end
	it "should reject duplicate email addresses" do
		user = User.create!(@attr)
		duplicate_email_user = User.new(@attr)
		duplicate_email_user.should_not be_valid
		user.destroy
	end
	it "should reject email addresses identical up to case" do
		downcased_email = @attr[:email].downcase
		user = User.create!(@attr.merge(:email => downcased_email))
		duplicate_email_user = User.new(@attr)
		duplicate_email_user.should_not be_valid
		user.destroy
	end
	describe "passwords" do
		before(:each) do
			@user = User.new(@attr)
		end
		it "should have a password attribute" do
			@user.should respond_to(:password)
		end
		it "should have a password confirmation attribute" do
			@user.should respond_to(:password_confirmation)
		end
	end
	describe "password validations" do

		it "should require a password" do
			User.new(@attr.merge(:password => '', :password_confirmation => '')).should_not be_valid
		end

		it "should have a matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => 'invalid')).should_not be_valid
		end

		it "should reject short passwords" do
			short = "a" * 5
			User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid
		end

		it "should reject long passwords" do
			long = "a" * 41
			User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
		end
	end

	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end

		after(:each) do
			@user.destroy
		end

		it "should have an encrypted password attribute" do
			@user.should respond_to(:password_digest)
		end

		it "should set the encrypted password attribute" do
			@user.password_digest.should_not be_blank
		end
	end

	describe "has_password? method" do
		before(:each) do
			@user = User.create!(@attr)
		end

		after(:each) do
			@user.destroy
		end

		it "should exist" do
			@user.should respond_to(:has_password?)
		end

		it "should return true if the passwords match" do
			@user.has_password?(@attr[:password]).should be_true
		end

		it "should return false if the passwords do not match" do
			@user.has_password?("invalid").should_not be_true
		end

	end

	describe "verify method" do
		before(:each) do
			@user = User.create!(@attr)
		end

		after(:each) do
			@user.destroy
		end

		it "should exist" do
			User.should respond_to(:verify)
		end

		it "should return nil on email/password mismatch" do
			User.verify(@attr[:email], "wrongpass").should be_nil
			end

		it "should return nil for an email address with no user" do
			User.verify("bar@bar.foo", @attr[:password]).should be_nil
		end

		it "should return the user on email/password match" do
			User.verify(@attr[:email], @attr[:password]).should == @user
		end

	end
	describe "admin attribute" do
		before(:each) do
			@user = User.create!(@attr)
		end
		it "should respond to admin" do
			@user.should respond_to(:admin)
		end
		it "should not be an admin by default" do
			@user.should_not be_admin
		end
		it "should be convertible to an admin" do
			@user.toggle!(:admin)
			@user.should be_admin
		end
	end
end
