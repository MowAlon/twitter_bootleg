class FavoritesController < ApplicationController

  def create
    status = current_user.twitter.status(params[:id])
    current_user.twitter.favorite(status)
    redirect_to profile_path
  end

  def destroy
    status = current_user.twitter.status(params[:id])
    current_user.twitter.unfavorite(status)
    redirect_to profile_path
  end

end
