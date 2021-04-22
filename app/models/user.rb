class User < ApplicationRecord
	has_many :reviews
	has_many :recipes

	has_secure_password
end
