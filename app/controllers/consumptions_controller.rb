class ConsumptionsController < ApplicationController
  before_action :require_login

  def new
    @consumption = participant.consumptions.new
    @consumption.count = 1 if @consumption.count.blank?
  end

  def index
    @consumptions = participant.consumptions.order(created_at: :desc)
  end

  def create
    @consumption = participant.consumptions.new(params.require(:consumption).permit(:count))

    if @consumption.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def participant
    @participant ||= Participant.find(params[:participant_id])
  end
end
