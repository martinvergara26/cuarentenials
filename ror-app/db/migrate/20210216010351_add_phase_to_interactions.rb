class AddPhaseToInteractions < ActiveRecord::Migration[6.1]
  def change
    add_reference :interactions, :phase, null: false, foreign_key: true
  end
end
