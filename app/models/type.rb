class Type < ActiveRecord::Base
    has_many :items
    validates :name, presence: true
    default_scope  { order(:name) }
end
