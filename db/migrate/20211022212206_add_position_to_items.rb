class AddPositionToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :position, :integer
  end
end
