class Item < ApplicationRecord
  belongs_to :checklist

  after_create_commit -> { broadcast_prepend_to "items" }

  acts_as_list
end
