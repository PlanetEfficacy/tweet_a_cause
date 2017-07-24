class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true
      t.references :charity, foreign_key: true
      t.integer :amount
      t.timestamps
    end
  end
end
