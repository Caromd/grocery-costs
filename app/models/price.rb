class Price < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :name, :date_bought, :item_id
end
