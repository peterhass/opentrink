class ScoreboardsController < ApplicationController
  layout 'presentation'

  def show
    @scoreboard = Score.fetch_scoreboard
  end
end
