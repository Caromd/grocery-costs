class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  has_many :prices, dependent: :restrict_with_error
  validates_presence_of :name, :type_id
  
  def subtotals
    items.map do |i| i.subtotal end
  end
  
  def total
    subtotals.sum
  end
end
