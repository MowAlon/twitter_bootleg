class StatusesController < ApplicationController

  def index
    @statuses = Status.new(current_user).all
  end

  def show
    @status = Status.find(params[:id])
  end

end
