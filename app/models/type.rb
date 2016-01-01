class Type < ActiveRecord::Base
    belongs_to :user
    has_many :items
    accepts_nested_attributes_for :items, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }
    validates :name, presence: true
    default_scope  { order(:name) }
end
