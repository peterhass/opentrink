class InvitationsController < ApplicationController
  before_action :require_admin

  def index
    @invitations = Invitation.all.newest_first
  end

  def create
    @invitation = Invitation.new(params.require(:invitation).permit(:role))

    @invitation.save!
    redirect_to action: :index
  end

  def update
    invitation.update!(params.require(:invitation).permit(:deactivated))
    redirect_to action: :index
  end

  private

  def invitation
    @invitation ||= Invitation.find_by(id: params[:id])
  end
end
