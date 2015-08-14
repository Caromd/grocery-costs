class Price < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :item
  validates :amount, presence: true
  validates :date_bought, presence: true
  default_scope  { order(:date_bought => :desc) }
  default_scope { includes(:item) }
  scope :items_by_name, -> { items.order(name: :asc) }
  
  def subtotal
    amount
  end
end
