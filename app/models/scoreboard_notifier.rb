class ScoreboardNotifier
  def initialize; end

  def notify!
    saved = false
    did_scoreboard_change = false

    ActiveRecord::Base.transaction do
      current_scoreboard_id = Score.fetch_scoreboard_id

      saved = yield
      return unless saved

      did_scoreboard_change = current_scoreboard_id != Score.fetch_scoreboard_id
    end

    ActionCable.server.broadcast('scoreboard', :updated) if did_scoreboard_change

    saved
  end
end
