class CreateTimeslotUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :timeslot_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :timeslot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
