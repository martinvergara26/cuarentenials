class AddPhaseToBirths < ActiveRecord::Migration[6.1]
  def change
    add_reference :births, :phase, null: false, foreign_key: true
  end
end
