class SessionsController < ApplicationController
  skip_before_action :store_session
  skip_before_action :require_login

  #FIXME: Shouldn't need this, but as it stands, logging in redirects to
  # sessions index. This redirects the user to the proper location.
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
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end

    redirect_after_login
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  def redirect_after_login
    redirect_to session[:return_to]
    session[:return_to] = nil
  end
end
