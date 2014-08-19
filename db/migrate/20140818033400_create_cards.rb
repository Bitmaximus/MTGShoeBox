class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :mId
      t.integer :relatedCardId
      t.integer :setNumber
      t.string :name
      t.string :searchName
      t.string :description
      t.string :flavor
      t.string :colors, array: true, default: []
      t.string :manaCost
      t.integer :convertedManaCost
      t.string :cardSetName
      t.string :type
      t.string :subType
      t.integer :power
      t.integer :toughness
      t.integer :loyalty
      t.string :rarity
      t.string :artist
      t.string :cardSetId
      t.boolean :token
      t.boolean :promo
      t.string rulings, array: true, default: []
      t.string formats, array: true, default: []
      t.date :releasedAt

      t.timestamps
    end
  end
end
