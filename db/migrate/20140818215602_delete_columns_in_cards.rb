class DeleteColumnsInCards < ActiveRecord::Migration
  def change
	  remove_columns :cards, :rulings, :formats
  end
end
