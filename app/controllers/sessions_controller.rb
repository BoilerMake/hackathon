class SessionsController < ApplicationController
  skip_before_action :require_login

  def index
    redirect_after_login
  end

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      flash[:success] = 'Logged in!'
      redirect_after_login
    else
      flash[:alert] = "Invalid email or password"
      redirect_to root_path
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end

  private

  def redirect_after_login
    if session[:return_to].present?
      redirect_to return_to
    else
      redirect_to dashboard_url
    end
  end
end
