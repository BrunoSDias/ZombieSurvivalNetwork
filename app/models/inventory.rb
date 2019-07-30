class Inventory < ApplicationRecord
  belongs_to :survivor
  validates :water, :food, :medication, :ammunition, presence: true
end
