class FriendshipsController < ApplicationController

  def destroy
    user = current_user.twitter.user(params[:id].to_i)
    current_user.twitter.unfollow(user)
    redirect_to profile_path
  end

end
