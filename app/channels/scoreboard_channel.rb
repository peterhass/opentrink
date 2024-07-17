class ScoreboardChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'scoreboard'
  end
end
