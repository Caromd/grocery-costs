class Item < ActiveRecord::Base
  belongs_to :type
  has_many :prices
  validates_presence_of :name, :type_id
end
