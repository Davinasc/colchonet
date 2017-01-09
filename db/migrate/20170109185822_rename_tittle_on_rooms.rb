class RenameTittleOnRooms < ActiveRecord::Migration[5.0]
  def change
  	rename_column :rooms, :tittle, :title
  end
end
