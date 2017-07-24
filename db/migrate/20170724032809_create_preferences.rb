class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.references :user, foreign_key: true
      t.references :charity, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
