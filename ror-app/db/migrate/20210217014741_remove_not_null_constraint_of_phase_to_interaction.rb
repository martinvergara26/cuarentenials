class RemoveNotNullConstraintOfPhaseToInteraction < ActiveRecord::Migration[6.1]
  def change
    change_column_null :interactions, :phase_id, true
  end
end
