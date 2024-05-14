class AddUidToParticipant < ActiveRecord::Migration[7.1]
  def change
    change_table :participants do |t|
      t.string :uid
    end
  end
end
