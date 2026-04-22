class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :city
      t.string :category
      t.date :event_date

      t.timestamps
    end
  end
end
