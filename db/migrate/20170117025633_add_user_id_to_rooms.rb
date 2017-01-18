class AddUserIdToRooms < ActiveRecord::Migration[5.0]
  def change
  	add_column :rooms, :user_id, :integer
    add_reference :rooms, :users, index: true, foreign_key: true
  end
end
