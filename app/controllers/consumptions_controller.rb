class ConsumptionsController < ApplicationController
  before_action :require_bar

  def new
    find_signed_participant

    unless participant
      render :new_error
      return
    end

    @consumption = participant.consumptions.new
    @consumption.count = 1 if @consumption.count.blank?
  end

  def index
    find_participant

    @consumptions = participant.consumptions.order(created_at: :desc)
  end

  def create
    find_participant

    @consumption = participant.consumptions.new(params.require(:consumption).permit(:count))

    if save_consumption_and_update_scoreboard(@consumption)
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  attr_reader :participant

  def find_signed_participant
    @participant = Participant.find_signed(params[:participant_id])
  end

  def find_participant
    @participant = Participant.find(params[:participant_id])
  end

  def save_consumption_and_update_scoreboard(consumption)
    saved = false
    did_scoreboard_change = false

    @consumption.transaction do
      current_scoreboard_id = Score.fetch_scoreboard_id

      saved = consumption.save
      return unless saved

      did_scoreboard_change = current_scoreboard_id != Score.fetch_scoreboard_id
    end

    ActionCable.server.broadcast('scoreboard', :updated) if did_scoreboard_change

    saved
  end
end
