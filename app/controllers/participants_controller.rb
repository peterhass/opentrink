class ParticipantsController < ApplicationController
  before_action :require_bar, except: %i[new create show]

  def index
    @participants = Participant.newest_first

    @filters = ParticipantFiltersForm.new(
      params.fetch(:participant_filters_form, {}).permit(:q)
    )
    @participants = @participants.search_by_name(@filters.q) if @filters.q
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

    respond_to do |format|
      format.html
      format.png do
        image_stream = RQRCode::QRCode.new(new_participant_url)
                                      .as_png(size: 500)
                                      .to_datastream

        send_data image_stream,
                  type: 'image/png',
                  disposition: 'inline'
      end
    end
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
