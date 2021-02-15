class CreatePhases < ActiveRecord::Migration[6.1]
  def change
    create_table :phases do |t|
      t.string :name

      t.timestamps
    end
  end
end
