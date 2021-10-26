class Checklist < ApplicationRecord
  has_many :items, -> { order(position: :asc) }
end
