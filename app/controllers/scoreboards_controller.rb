class ScoreboardsController < ApplicationController
  def show 
    @participant_scores = ParticipantScore.total_ranked
  end
end
