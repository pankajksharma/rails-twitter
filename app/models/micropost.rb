class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :post, presence: true, length: {maximum: 140}

	validates :user_id, presence: true
end
