class AddUserToGift < ActiveRecord::Migration[6.1]
  def change
    add_reference :gifts, :user, null: true, foreign_key: true
  end
end
