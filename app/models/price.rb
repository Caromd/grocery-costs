class Price < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :shopping_days
  validates_presence_of :item
  validates :amount, presence: true
#  default_scope  { order(:date_bought => :desc) }

  def subtotal
    amount
  end
  
  def self.summary(year, month)
    if year
      dt = DateTime.new(year,month,1)
      bom = dt.beginning_of_month
      eom = dt.end_of_month
      find(:all, :conditions => ["date_bought >= ? and date_bought <= ?", bom, eom])
    else
      find(self.all)
    end
  end
  
end