class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :current_user

  private
  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
          redirect_to root_path
      end
  end
end
