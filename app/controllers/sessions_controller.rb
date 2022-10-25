class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to(users_path(user))
    else
      flash[:failure] = 'Invalid email/password combination'
      redirect_to(login_path)
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
