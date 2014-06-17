class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    binding.pry
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
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(@user.class.to_s.downcase).permit(:first_name, :last_name, :password_confirmation, :password, :password_digest, :school_id, :team_id, :email, :gender, :expected_graduation, :github, :tshirt_size, :cell_phone, :linkedin, :dietary_restrictions, :previous_experience, :essay, :school_other)
  end
end
