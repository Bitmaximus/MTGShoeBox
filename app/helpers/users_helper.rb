module UsersHelper
	def gravatar_for(user, options =  { :size => 50})
		gravatar_image_tag(user.email.downcase, :alt => user.name, :class => 'gravatar', :gravatar => options)
	end

	def fetchcardsintodb
		$magic = "http://api.mtgdb.info/cards/"
		response = Net::HTTP.get_response(URI.parse($magic))
		data = begin IO.read('public/cards.json') rescue "" end
		arr = JSON.parse(data, opts = {:symbolize_names => true}    )
		arr[0,1000].each do |hash|
		Card.create(:mId => hash[:id], :relatedCardId => hash[:relatedCardId], :setNumber => hash[:setNumber], :name => hash[:name], :searchName => hash[:searchName], :description => hash[:description], :flavor => hash[:flavor], :colors => hash[:colors], :manaCost => hash[:manaCost], :convertedManaCost => hash[:convertedManaCost], :cardSetName => hash[:cardSetName], :mtgType => hash[:type], :subType => hash[:subType], :power => hash[:power],  :toughness => hash[:toughness], :loyalty => hash[:loyalty], :rarity => hash[:rarity], :artist => hash[:artist], :cardSetId =>  hash[:cardSetId], :token => hash[:token], :promo => hash[:promo], :releasedAt => hash[:releasedAt])
			end
	end

end


