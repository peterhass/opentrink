class CreateParticipantScores < ActiveRecord::Migration[7.1]
  def change
    create_view :participant_scores
  end
end
