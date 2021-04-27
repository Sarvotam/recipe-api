class User < ApplicationRecord
	has_many :reviews
	has_many :recipes

	has_secure_password

	# validates :user, presence: false
end
