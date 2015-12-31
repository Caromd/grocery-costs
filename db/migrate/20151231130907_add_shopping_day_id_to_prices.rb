class AddShoppingDayIdToPrices < ActiveRecord::Migration
  def change
    add_reference :prices, :shopping_day, index: true, foreign_key: true
  end
end
