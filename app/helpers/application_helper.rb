module ApplicationHelper
	def title
		base_title = "MTG ShoeBox"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag('shoeboxv2.jpg', alt: 'Tis a Shoebox!', size: '200x90', class: 'round')
	end
end
