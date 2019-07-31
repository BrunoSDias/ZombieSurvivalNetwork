class Survivor < ApplicationRecord
    has_one :inventory, class_name: 'Inventory'
    validates :name, :age, :gender, :latitude, :longitude, presence: true

    accepts_nested_attributes_for :inventory, allow_destroy: true
end
