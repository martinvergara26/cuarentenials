class CreateGivenGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :given_gifts do |t|
      t.references :user, null: true, foreign_key: true
      t.references :gift, null: false, foreign_key: true
      t.references :birth, null: false, foreign_key: true

      t.timestamps
    end
  end
end
