class CreateTimeslots < ActiveRecord::Migration[6.1]
  def change
    create_table :timeslots do |t|
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
