class SessionsController < ApplicationController
  skip_before_action :require_login
  before_filter :downcase_email

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
    flash[:notice] = 'Logged out!'
    redirect_to root_url
  end

  private

  def redirect_after_login
    sleep(2)
    if session[:return_to].present?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      if current_user.exec?
        redirect_to execs_dashboard_url
      else
        redirect_to dashboard_url
      end
    end
  end

  def downcase_email
    params[:email].downcase! if params[:email]
  end
end
