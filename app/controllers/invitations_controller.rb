class InvitationsController < ApplicationController
  before_action :require_admin

  def index
    @invitations = Invitation.all.newest_first
  end

  def create
    @invitation = Invitation.new(invitation_params)

    @invitation.save!
    redirect_to action: :index
  end

  private

  def invitation_params
    params.require(:invitation).permit(:role)
  end
end
