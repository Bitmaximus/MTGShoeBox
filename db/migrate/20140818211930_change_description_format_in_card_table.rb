class ChangeDescriptionFormatInCardTable < ActiveRecord::Migration
  def change
	  change_column :cards, :description, :text
	  change_column :cards, :flavor, :text
  end
end
