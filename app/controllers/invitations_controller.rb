class InvitationsController < ApplicationController
  before_action :require_admin

  def index
    @invitations = Invitation.all.newest_first
  end
end
