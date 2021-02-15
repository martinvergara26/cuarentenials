class CreateBirths < ActiveRecord::Migration[6.1]
  def change
    create_table :births do |t|
      t.date :estimated_date
      t.string :name

      t.timestamps
    end
  end
end
