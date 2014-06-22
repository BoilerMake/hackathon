class HackersController < ApplicationController
  before_action :set_hacker, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:update, :destroy, :dashboard]
  skip_before_action :require_login, :store_session

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
    if params[:school_other] == '1'
      school = School.create(name: hacker_params[:school_id])
      new_params = hacker_params
      new_params[:school_id] = school.id
      @hacker = Hacker.new(new_params)
    else
      @hacker = Hacker.new(hacker_params)
    end

    respond_to do |format|
      if @hacker.save

        # mimics sessions/create
        user = User.find(@hacker.id)
        cookies[:auth_token] = user.auth_token

        if session[:return_to].present?
          format.html { redirect_to session[:return_to], notice: 'Account Created! Please confirm your email.' }
        else
          format.html { redirect_to :dashboard, notice: 'Account Created! Please confirm your email.' }
        end

        format.json { render :show, status: :created, location: @hacker }
      else
        flash[:notice] = "Invalid email or passwords do not match"
        format.html { redirect_to root_path }
        format.json { render json: @hacker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @hacker.update(hacker_params)
        format.html { redirect_to :dashboard, notice: 'Hacker was successfully updated.' }
        format.json { render :show, status: :ok, location: @hacker }
      else
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hacker
    @hacker = Hacker.find(params[:id])
  end

  def authenticate
    redirect_to root_url, notice: 'Not Logged in' unless current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hacker_params
    params.require(:hacker).permit(:first_name, :last_name, :password, :password_digest, :password_confirmation, :school_id, :team_id, :email, application_attributes: [ :gender, :expected_graduation, :github, :tshirt_size, :cell_phone, :linkedin, :dietary_restrictions, :previous_experience, :essay, :school_other ])
  end
end
