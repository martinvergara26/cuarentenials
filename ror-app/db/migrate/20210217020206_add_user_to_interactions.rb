class AddUserToInteractions < ActiveRecord::Migration[6.1]
  def change
    add_reference :interactions, :user, null: true, foreign_key: true
  end
end
