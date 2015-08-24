class Type < ActiveRecord::Base
    has_many :items, dependent: :restrict_with_error
    validates :name, presence: true
    default_scope  { order(:name) }
end
