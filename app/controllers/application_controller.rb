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

  def can_participate?
    current_participant&.activated?
  end

  def can_admin?
    current_user&.activated? && current_user&.admin?
  end

  def require_admin
    return if can_admin?

    # TODO
    not_authenticated
  end

  def can_bar?
    current_user&.activated? && (current_user&.bar? || current_user&.admin?)
  end

  def require_bar
    return if can_bar?

    # TODO
    not_authenticated
  end
end
