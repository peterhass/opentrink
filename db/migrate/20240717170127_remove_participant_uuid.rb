class RemoveParticipantUuid < ActiveRecord::Migration[7.1]
  def change
    remove_column :participants, :uuid
  end
end
