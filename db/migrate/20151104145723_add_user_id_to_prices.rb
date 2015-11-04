class AddUserIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :user_id, :integer
  end
end
