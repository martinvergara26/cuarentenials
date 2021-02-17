class AddApprovedToInteractions < ActiveRecord::Migration[6.1]
  def change
    add_column :interactions, :approved, :boolean, default: true
  end
end
