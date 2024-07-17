class Score < ApplicationRecord
  def self.fetch_scoreboard
    scores = Score.all
    return nil if scores.empty?

    Scoreboard.new(
      id: scores[0].board_id,
      participant_scores: scores.map(&:participant_score)
    )
  end

  def participant_score
    becomes(ParticipantScore)
  end

  class Scoreboard
    attr_reader :id, :participant_scores

    def initialize(id:, participant_scores:)
      @id = id
      @participant_scores = participant_scores
    end
  end
end
