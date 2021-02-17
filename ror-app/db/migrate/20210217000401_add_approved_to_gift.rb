class AddApprovedToGift < ActiveRecord::Migration[6.1]
  def change
    add_column :gifts, :approved, :boolean, default: true
  end
end
