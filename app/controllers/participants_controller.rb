class ParticipantsController < ApplicationController
  def index
    @participants = Participant.newest_first
  end

  def show
    @participant = Participant.find_by(uid: params[:id])
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(params.require(:participant).permit(:name))

    if @participant.save
      redirect_to action: :show, id: @participant.uid
    else
      render :new, status: :unprocessable_entity
    end
  end
end
