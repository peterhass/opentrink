class ApplicationController < ActionController::Base

  private

  def require_admin
    return if current_user&.admin?

    # TODO
    not_authenticated
  end

  def require_bar
    return if current_user&.bar? || current_user&.admin?

    # TODO
    not_authenticated
  end
end
