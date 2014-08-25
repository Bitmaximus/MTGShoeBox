class CardsController < ApplicationController
  def index
	  @title = "Card Database"
end

  def show
  end

  def create
	  if current_user.nil?
		  flash.now[:error] = "Please Sign In Before Adding Cards"
		  @title = "Sign In"
		  render 'users/new'
	  else
		  current_user.cards.create(:mId => params[:mId], :relatedCardId => params[:relatedCardId], :setNumber => params[:setNumber], :name => params[:name], :searchName => params[:searchName], :description => params[:description], :flavor => params[:flavor], :colors => params[:colors], :manaCost => params[:manaCost], :convertedManaCost => params[:convertedManaCost], :cardSetName => params[:cardSetName], :mtgType => params[:mtgType], :subType => params[:subType], :power => params[:power],  :toughness => params[:toughness], :loyalty => params[:loyalty], :rarity => params[:rarity], :artist => params[:artist], :cardSetId =>  params[:cardSetId], :token => params[:token], :promo => params[:promo], :releasedAt => params[:releasedAt], :user_id => current_user)
	  end
  end

  def new
  end

  def edit
  end
end
