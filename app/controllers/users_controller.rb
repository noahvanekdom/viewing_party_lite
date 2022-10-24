class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @parties = @user.parties
    # #@hosted_parties = @user.parties.where(host_status: true)
  end

  def discover
    @user = User.find(params[:user_id])
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

  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      redirect_to user_path(user)
      flash[:success] = "Welcome back, #{user.email}!"
    else
      redirect_to '/login'
      flash[:error] = 'Invalid Credentials'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
