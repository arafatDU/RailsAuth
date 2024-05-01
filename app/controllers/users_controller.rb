class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def bulk_update
    notice_message = ''
    User.transaction do
      user_names = User.where(id: params[:user_ids]).pluck(:name)
      case params[:commit]
      when 'block'
        User.where(id: params[:user_ids]).update_all(status: 'blocked')
        notice_message = "#{user_names.join(', ')} blocked successfully."
      when 'unblock'
        User.where(id: params[:user_ids]).update_all(status: 'active')
        notice_message = "#{user_names.join(', ')} unblocked successfully."
      when 'delete'
        User.where(id: params[:user_ids]).destroy_all
        notice_message = "#{user_names.join(', ')} deleted successfully."
      end
    end
    redirect_to users_path, notice: notice_message
  end
end
