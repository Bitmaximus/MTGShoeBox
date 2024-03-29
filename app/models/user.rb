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

class User < ActiveRecord::Base
has_many :cards, dependent: :destroy
	has_secure_password
	validates :name,  presence: true,
	                  length: { maximum: 50 }

	VALID_EMAIL_REGEX = /[\w+.\-]+@[a-z\d\-]+[\.][a-z]+/i

	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { :case_sensitive => false }
	validates :password, presence: true, length: { within: 6..40 }

	def has_password?(submitted_password)
		self.authenticate(submitted_password)
	end

	def self.verify(email, submitted_password)
		user = find_by_email(email)
	if user.nil?
		return nil
	elsif !user.authenticate(submitted_password)
		return nil
	else
		user.authenticate(submitted_password)
	end
	end
	end


