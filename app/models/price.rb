class Price < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :item
  validates :amount, presence: true
  validates :date_bought, presence: true
  default_scope  { order(:date_bought => :desc) }
end
