# == Schema Information
#
# Table name: cards
#
#  id                :integer          not null, primary key
#  mId               :integer
#  relatedCardId     :integer
#  setNumber         :integer
#  name              :string(255)
#  searchName        :string(255)
#  description       :string(255)
#  flavor            :string(255)
#  colors            :string(255)      default([]), is an Array
#  manaCost          :string(255)
#  convertedManaCost :integer
#  cardSetName       :string(255)
#  type              :string(255)
#  subType           :string(255)
#  power             :integer
#  toughness         :integer
#  loyalty           :integer
#  rarity            :string(255)
#  artist            :string(255)
#  cardSetId         :string(255)
#  token             :boolean
#  promo             :boolean
#  rulings           :string(255)      default([]), is an Array
#  formats           :string(255)      default([]), is an Array
#  releasedAt        :date
#  created_at        :datetime
#  updated_at        :datetime
#

class Card < ActiveRecord::Base
	belongs_to :user
	validates :user_id,  presence: true
end
