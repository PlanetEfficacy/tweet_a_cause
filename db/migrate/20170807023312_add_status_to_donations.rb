class AddStatusToDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :donations, :complete, :boolean, default: false 
  end
end
