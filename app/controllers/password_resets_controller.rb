class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password &crarr;
                                                      reset has expired."
    elsif @user.update_attributes user_params
      redirect_to root_url, notice: "Password has been reset."
    else
      render :edit
    end
  end

  def create
    user = User.find_by_email(params[:email])

    if user
      user.send_password_reset
      reset_msg = 'Email sent with password reset instructions'
    else
      reset_msg = 'Email address not found, no reset sent'
    end
    redirect_to root_url, notice: reset_msg
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(@user.class.to_s.downcase).permit(:first_name, :last_name, :password_confirmation, :password, :password_digest, :school_id, :team_id, :email, :school_other)
  end
end
