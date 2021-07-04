class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.integer :user_id
      t.string :location
      t.string :type_of_bike
      t.string :brand
      t.string :size_of_bike
      t.string :condition
      t.boolean :available, :default => true
    end  
  end
end
