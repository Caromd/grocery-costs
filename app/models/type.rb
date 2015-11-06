class Type < ActiveRecord::Base
    belongs_to :user
    has_many :items, dependent: :restrict_with_error
    validates :name, presence: true
    default_scope  { order(:name) }
end
