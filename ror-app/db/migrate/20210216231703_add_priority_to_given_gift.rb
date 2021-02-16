class AddPriorityToGivenGift < ActiveRecord::Migration[6.1]
  def change
    add_column :given_gifts, :priority, :integer
  end
end
