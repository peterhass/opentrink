class CreateConsumptions < ActiveRecord::Migration[7.1]
  def change
    create_table :consumptions do |t|
      t.integer :count
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
