class AddBirthToTimeslots < ActiveRecord::Migration[6.1]
  def change
    add_reference :timeslots, :birth, null: false, foreign_key: true
  end
end
