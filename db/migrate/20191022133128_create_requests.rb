class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
    t.integer :requester_bike_id
    t.integer :requestee_bike_id
    t.boolean :swap_completed
    end
  end
end
