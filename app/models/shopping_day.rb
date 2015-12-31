class ShoppingDay < ActiveRecord::Base
  belongs_to :user
  has_many :prices
  accepts_nested_attributes_for :prices
end
