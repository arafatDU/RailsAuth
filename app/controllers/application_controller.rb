class ApplicationController < ActionController::Base
  before_action :check_if_blocked

  protected

  def after_sign_in_path_for(resource)
    users_path
  end

  private

  def check_if_blocked
    if current_user&.blocked?
      sign_out current_user
      redirect_to new_user_session_path, alert: 'Your account has been blocked.'
    end
  end
end
