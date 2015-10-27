class SessionsController < ApplicationController

  def create
    # user = User.from_omniauth(request.env["omniauth.auth"])
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to profile_path
    else
      redirect_to root_path
    end
    # render text: user.attributes
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
