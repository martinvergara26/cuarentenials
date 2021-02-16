class CreateInteractions < ActiveRecord::Migration[6.1]
  def change
    create_table :interactions do |t|
      t.string :name
      t.integer :allowed_attendees, default: 1
      t.string :csv_not_allowed_days, default: ''
      t.integer :allowed_times_a_day, default: 1

      t.timestamps
    end
  end
end
