class ParticipantsController < ApplicationController
  before_action :require_bar, except: %i[new create show]

  def index
    @participants = Participant.newest_first
  end

  def show
    @participant = Participant.find_by!(id: params[:id])

    raise 'not allowed' unless @participant.id == current_participant&.id
  end

  def manage
    @participant = Participant.find_by!(id: params[:id])
  end

  def new
    @participant = Participant.new
  end

  def update
    participant = Participant.find_by!(id: params[:id])

    ScoreboardNotifier.new.notify! do
      participant.update!(params.require(:participant).permit(:deactivated))
    end

    redirect_to action: :manage
  end

  def create
    @participant = Participant.new(params.require(:participant).permit(:name))

    if @participant.save
      self.current_participant = @participant
      redirect_to action: :show, id: @participant.id
    else
      render :new, status: :unprocessable_entity
    end
  end
end
