class CreateActivitySignups < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_signups do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :activity_signups, [ :activity_id, :user_id ], unique: true
  end
end
