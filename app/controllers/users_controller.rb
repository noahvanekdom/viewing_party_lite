class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to(user_path(user))
      flash[:notice] = "Welcome #{user.name}"
    else
      redirect_to('/register')
      flash[:failure] = user.errors.full_messages.first
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end