class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.string :type_of_bike
      t.string :brand
      t.string :size_of_bike
      t.string :condition
      t.text :description
    end  
  end
end
