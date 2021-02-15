class AddPhaseToGifts < ActiveRecord::Migration[6.1]
  def change
    add_reference :gifts, :phase, foreign_key: true
  end
end
