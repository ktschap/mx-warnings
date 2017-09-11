class CreateTravelWarnings < ActiveRecord::Migration[5.1]
  def change
    create_table :travel_warnings do |t|
      t.string :name
      t.string :fullname
      t.string :detail

      t.timestamps
    end
  end
end
