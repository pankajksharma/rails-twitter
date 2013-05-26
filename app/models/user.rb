class User < ActiveRecord::Base
	has_many :micropost
	# Following - follwers modeling
	# has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	# has_many :followed_users, through: :relationships, source: :followed
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	validates :password, presence: true, length: {minimum: 6}
	has_secure_password
	validates :password_confirmation, presence: true

	def following?(other_user)
      relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
      relationships.find_by(followed_id: other_user.id).destroy
    end

end
