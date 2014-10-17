class HackersController < ApplicationController
  before_filter :set_genders, :downcase_email, :set_shirts
  before_action :set_hacker, only: [:update, :destroy]
  before_filter :authenticate, only: [:update, :destroy, :dashboard]
  skip_before_action :require_login
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @hackers = Hacker.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @hacker
  end

  def dashboard
    @schools = School.all
    @hacker ||= current_user
    @application = @hacker.application
    @application ||= @hacker.build_application
    @school = @hacker.school.name if @hacker.school

    @resume_button_text = @application.resume.present? ? 'Replace Resume': 'Pick File'
  end

  # GET /users/new
  def new
    @hacker = Hacker.new
    @schools = School.all
    @applying = true
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @hacker = Hacker.new(hacker_params)

    respond_to do |format|
      if @hacker.save

        # mimics sessions/create
        user = User.find(@hacker.id)
        cookies[:auth_token] = user.auth_token

        UserMailer.welcome_email(@hacker).deliver

        if session[:return_to].present?
          format.html { redirect_to session[:return_to], notice: 'Account created successfully.' }
        else
          format.html { redirect_to :dashboard, notice: 'Account created successfully.' }
        end

        format.json { render :show, status: :created, location: @hacker }
      else
        if @hacker.errors[:email].present?
          flash[:alert] = "#{@hacker.email} #{@hacker.errors[:email][0]}"
        elsif @hacker.errors[:password_confirmation].present?
          flash[:alert] = "Your passwords don't match."
        else
          flash[:alert] = "Some error occured. Email support@boilermake.org."
        end
        format.html { redirect_to root_path }
        format.json { render json: @hacker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    new_params = hacker_params
    if hacker_params[:school_id].present?
      school = School.find_by(name: hacker_params[:school_id])
      if school
        school_id = School.find_by(name: hacker_params[:school_id]).id
        new_params[:school_id] = school_id
      else
        new_params[:school_id] = -1 # this won't update
      end
    else
      new_params[:school_id] = nil
    end
    respond_to do |format|
      if @hacker.update(new_params) && new_params[:school_id] != -1
        flash[:success] = "Your application has been updated."
        format.html { redirect_to :dashboard }
        format.json { render :show, status: :ok, location: @hacker }
      else
        flash[:error] = "That school doesn't exist. Email team@boilermake.org." if new_params[:school_id] == -1
        format.html { render :dashboard }
        format.json { render json: @hacker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @hacker.destroy
    respond_to do |format|
      format.html { redirect_to hackers_url, notice: 'Hacker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    if current_user.accepted? && current_user.application_completed?
      current_user.update(confirmed: true)
      redirect_to dashboard_path
    else
      redirect_to root_path, flash: { error: "Nice try, but you can't get in that way" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hacker
    @hacker = Hacker.find(params[:id])
  end

  def authenticate
    redirect_to root_url, notice: 'Not Logged in' unless current_user
  end

  def set_genders
    @genders = ['Male', 'Female', 'Other', 'Prefer Not to Specify']
  end

  def set_shirts
    @shirts = ['Small', 'Medium', 'Large', 'XL', 'XXL']
  end

  def downcase_email
    if params[:hacker]
      params[:hacker][:email].downcase! if params[:hacker][:email]
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hacker_params
    params.require(:hacker).permit(:first_name, :last_name, :password, :password_digest, :password_confirmation, :school_id, :team_id, :email, application_attributes: [ :id, :gender, :address_line_one, :address_line_two, :city, :state, :zip_code, :expected_graduation, :github, :tshirt_size, :cell_phone, :resume, :linkedin, :badge_id, :dietary_restrictions, :previous_experience, :essay, :school_other ])
  end
end
