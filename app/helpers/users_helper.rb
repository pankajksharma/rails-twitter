module UsersHelper
	def gravatar_for(user, *options)
		gravtar_id = Digest::MD5::hexdigest(user.email)
		gravtar_url = "http://secure.gravatar.com/avatar/#{gravtar_id}"
		image_tag gravtar_url, alt: user.name, class: 'gravatar'
	end
end
