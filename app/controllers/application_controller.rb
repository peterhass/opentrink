class ApplicationController < ActionController::Base

  private

  def current_participant=(participant)
    session[:participant_id] = participant.id
  end

  helper_method :current_participant
  def current_participant
    return nil unless session[:participant_id]

    @current_participant ||= Participant.find_by(id: session[:participant_id])
  end

  def require_admin
    return if current_user&.activated? && current_user&.admin?

    # TODO
    not_authenticated
  end

  def require_bar
    return if current_user&.activated? && (current_user&.bar? || current_user&.admin?)

    # TODO
    not_authenticated
  end
end
