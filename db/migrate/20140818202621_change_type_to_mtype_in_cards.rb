class ChangeTypeToMtypeInCards < ActiveRecord::Migration
  def change
	 rename_column :cards, :type, :mtgType
	  end
  end
