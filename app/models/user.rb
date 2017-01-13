class User < ApplicationRecord
	before_save :downcase_email
	before_create :generate_token

	validates_presence_of :full_name, :location
	validates :bio, length: { minimum: 30 }, allow_blank: false

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
	validates :email, presence: true, length: { maximum: 200 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	has_secure_password

	

	def generate_token
		self.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?		
	end

	private

		def downcase_email
			self.email = email.downcase
		end
end
