class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.integer :place_id
      t.integer :career_id
    end
  end
end
