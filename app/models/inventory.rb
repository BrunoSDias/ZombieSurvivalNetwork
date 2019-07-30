class Inventory < ApplicationRecord
  belongs_to :survivor
  validates :water, :food, :medication, :ammunition, presence: true
  validates :water, :food, :medication, :ammunition, :numericality => { :greater_than_or_equal_to => 0 }
end
