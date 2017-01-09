class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.text :bio
      t.string :password
      t.string :email
      t.string :location

      t.timestamps
    end
  end
end
