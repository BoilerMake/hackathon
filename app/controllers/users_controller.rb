class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :school_id,
                                   :team_id,
                                   :email,
                                   :gender,
                                   :expected_graduation,
                                   :github,
                                   :tshirt_size,
                                   :cell_phone,
                                   :linkedin,
                                   :major,
                                   :dietary_restrictions,
                                   :previous_experience,
                                   :essay,
                                   :school_other,
                                   :major,
                                   :degree,
                                   :essay1,
                                   :essay2,
                                   :race,
                                   :ethnicity,
                                   :grad_date,
                                   :job_interest,
                                   :job_date
                                   )
    end
end
