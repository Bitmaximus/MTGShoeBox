module CardsHelper
	include SessionsHelper
	def fetchcardsintodb
		data = begin IO.read('public/cards.json') rescue "" end
		arr = JSON.parse(data, opts = {:symbolize_names => true}    )
		arr[0, 5].each do |hash|
			current_user.cards.create(:mId => hash[:id], :relatedCardId => hash[:relatedCardId], :setNumber => hash[:setNumber], :name => hash[:name], :searchName => hash[:searchName], :description => hash[:description], :flavor => hash[:flavor], :colors => hash[:colors], :manaCost => hash[:manaCost], :convertedManaCost => hash[:convertedManaCost], :cardSetName => hash[:cardSetName], :mtgType => hash[:type], :subType => hash[:subType], :power => hash[:power],  :toughness => hash[:toughness], :loyalty => hash[:loyalty], :rarity => hash[:rarity], :artist => hash[:artist], :cardSetId =>  hash[:cardSetId], :token => hash[:token], :promo => hash[:promo], :releasedAt => hash[:releasedAt], :user_id => current_user)
		end
	end
	def fetcharray
		data = begin IO.read('public/cards.json') rescue "" end
		arr = JSON.parse(data, opts = {:symbolize_names => true}    )
	end
end
