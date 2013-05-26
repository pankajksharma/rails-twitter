module ApplicationHelper
	def page_title(sub_title)
		base_title = "Twitter App"
		if sub_title.empty?
			base_title
		else
			"#{base_title} | #{sub_title}"
		end
	end
end
