class Room < ApplicationRecord
	belongs_to :user
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room

	scope :most_recent, -> { order('created_at DESC') }

	def complete_name
		"#{title}, #{location}"
	end

	def self.search(query)
		if query.present?
			where(['location LIKE :query OR
							title LIKE :query OR
							description LIKE :query', query: "%#{query}%"])
		else
			all
		end
	end

end