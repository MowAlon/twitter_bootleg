class StatusesController < ApplicationController

  def new
    @user = current_user.twitter.user
  end

  def create
    current_user.twitter.update(params[:status])
    redirect_to profile_path
  end

  def destroy
    status = current_user.twitter.status(params[:id])
    current_user.twitter.destroy_status(status)
    redirect_to profile_path
  end

end
