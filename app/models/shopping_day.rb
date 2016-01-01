class ShoppingDay < ActiveRecord::Base
  belongs_to :user
  has_many :prices
  accepts_nested_attributes_for :prices, :allow_destroy => true, reject_if: proc { |attributes| attributes['amount'].blank? }
end
