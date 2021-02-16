class AddInteractionToTimeslots < ActiveRecord::Migration[6.1]
  def change
    add_reference :timeslots, :interaction, null: true, foreign_key: true
  end
end
