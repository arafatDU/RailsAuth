class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def bulk_update
    User.transaction do
      case params[:commit]
      when 'block'
        User.where(id: params[:user_ids]).update_all(status: 'blocked')
      when 'unblock'
        User.where(id: params[:user_ids]).update_all(status: 'active')
      when 'delete'
        User.where(id: params[:user_ids]).destroy_all
      end
    end
    redirect_to users_path, notice: 'Users updated.'
  end
end
