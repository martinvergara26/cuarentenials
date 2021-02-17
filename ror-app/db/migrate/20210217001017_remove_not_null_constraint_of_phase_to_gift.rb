class RemoveNotNullConstraintOfPhaseToGift < ActiveRecord::Migration[6.1]
  def change
    change_column_null :gifts, :phase_id, true
  end
end
