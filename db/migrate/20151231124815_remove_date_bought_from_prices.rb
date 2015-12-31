class RemoveDateBoughtFromPrices < ActiveRecord::Migration
  def change
    remove_column :prices, :date_bought, :date
  end
end
