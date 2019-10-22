class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phone_number
      t.string :email
      t.string :location
      t.text :looking_for
    end  
  end
end
