class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
    t.string :pending_requests_sent
    t.string :pending_requests_received
    t.boolean :swap_completed
    end
  end
end
