class InvitationsController < ApplicationController
  def index
    @invitations = Invitation.all.newest_first
  end
end
