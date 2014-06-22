class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  helper_method :hacker_full_name, :hacker_email, :hacker_school, :remove_hacker

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    redirect_to dashboard_url if current_user.team_id != @team.id
  end

  # GET /teams/new
  def new
    @team = Team.new

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end

    add_hacker(@team, current_user)
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team created successfully.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    store_session
    @team = Team.find_by_secret_key(params[:secret_key])
    if @team
      current_user.team_id = @team.id
      if current_user.save
        flash[:info] = 'Joined team successfully!'
      else
        flash[:warning] = 'Team is currently full'
      end
      current_user.save!
      redirect_to dashboard_url
    else
      redirect_to dashboard_url, alert: 'Invalid team key'
    end
  end

  def remove_hacker
    @team = Team.find(params[:id])
    @user = current_user
    @team.hackers.delete(@user)
    redirect_to dashboard_url
  end

  def add_hacker(team, hacker)
    hacker.update(team_id: team.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params[:team]
    end
end
