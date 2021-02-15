class AddUserToBirths < ActiveRecord::Migration[6.1]
  def change
    add_reference :births, :user, null: false, foreign_key: true
  end
end
