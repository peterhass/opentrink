class AddDeactivatedToParticipant < ActiveRecord::Migration[7.1]
  def change
    change_table :participants do |t|
      t.boolean :deactivated, default: false
    end
  end
end
