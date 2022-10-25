class UsersController < ApplicationController
  before_action :current_user, :logged_in_user,  only: [:show, :discover]

  def show
    @user = User.find(session[:user_id])
    @parties = @user.parties
    # #@hosted_parties = @user.parties.where(host_status: true)
  end

  # def login_form
  # end

  # def login_user
  #   user = User.find_by(name: params[:name])
  #   if user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     flash[:success] = "Welcome, #{user.name}!"
  #     redirect_to user_discover_path(user)
  #   else
  #     flash[:error] = "Sorry, your credentials are bad."
  #     render :login_form
  #   end
  # end

  def discover
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new
  end

  # def create
  #   user = User.new(user_params)
  #   user[:email] = user[:email].downcase
  #   # if user[:password] != user[:password_confirmation]
  #   #   flash[:failure] = 'Passwords must match'
  #   if user.save
  #     session[:user_id] = user.id
  #     redirect_to(user_path(user))
  #     flash[:notice] = "Welcome #{user.name}"
  #   else
  #     redirect_to(new_user_path)
  #     flash[:failure] = user.errors.full_messages.first
  #   end
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to(users_path)
    else
      redirect_to(new_user_path)
      flash[:failure] = @user.errors.full_messages.first
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
