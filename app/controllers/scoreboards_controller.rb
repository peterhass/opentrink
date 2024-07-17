class ScoreboardsController < ApplicationController
  def show
    @scoreboard = Score.fetch_scoreboard
  end
end
