class CreateShoppingDays < ActiveRecord::Migration
  def change
    create_table :shopping_days do |t|
      t.date :date_bought
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
