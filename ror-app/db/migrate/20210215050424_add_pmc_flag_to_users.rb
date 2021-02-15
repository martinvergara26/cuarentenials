class AddPmcFlagToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_pmc, :boolean
  end
end
