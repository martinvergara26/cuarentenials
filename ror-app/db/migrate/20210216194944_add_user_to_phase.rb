class AddUserToPhase < ActiveRecord::Migration[6.1]
  def change
    add_reference :phases, :user, null: true, foreign_key: true
  end
end
