class UsersController < ApplicationController

  def show
    @statuses = Status.new(current_user).all
  end
end
