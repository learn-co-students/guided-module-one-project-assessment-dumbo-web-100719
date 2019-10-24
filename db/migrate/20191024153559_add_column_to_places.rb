class AddColumnToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :lifestyle, :string
  end
end
