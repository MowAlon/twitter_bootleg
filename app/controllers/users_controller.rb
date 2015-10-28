class UsersController < ApplicationController

  def show
    @user = current_user.twitter.user
    @statuses = current_user.twitter.home_timeline
  end
end
