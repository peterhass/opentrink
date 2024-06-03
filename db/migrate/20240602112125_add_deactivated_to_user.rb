class AddDeactivatedToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.boolean :deactivated, default: false
    end
  end
end
