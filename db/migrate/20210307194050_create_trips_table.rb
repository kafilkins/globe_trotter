class CreateTripsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :location
      t.string :description
      t.string :adventures
      t.integer :user_id
    end
  end
end
