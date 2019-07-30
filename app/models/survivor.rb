class Survivor < ApplicationRecord
    has_one :inventory
    validates :name, :age, :gender, :latitude, :longitude, presence: true

    accepts_nested_attributes_for :inventory, allow_destroy: true
end
