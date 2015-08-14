class Item < ActiveRecord::Base
  belongs_to :type
  has_many :prices
  validates_presence_of :name, :type_id
#  default_scope  { order(:type_id, :name) }
  
  def subtotals
    items.map do |i| i.subtotal end
  end
  
  def total
    subtotals.sum
  end
end
