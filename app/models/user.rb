class User < ApplicationRecord
	before_save :downcase_email


	validates_presence_of :full_name, :location
	validates :bio, length: { minimum: 30 }, allow_blank: false

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
	validates :email, presence: true, length: { maximum: 200 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	has_secure_password

	private

		def downcase_email
			self.email = email.downcase
		end
end
