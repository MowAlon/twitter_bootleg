class RetweetsController < ApplicationController

  def create
    status = current_user.twitter.status(params[:id])
    current_user.twitter.retweet(status)
    redirect_to profile_path
  end

end
