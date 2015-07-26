class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :category_selection, only: [:edit, :new]
  skip_before_action :require_login
  load_and_authorize_resource

  # GET /schools
  # GET /schools.json
  def index
    if request.format.json?
      @schools = School.all
    else
      @schools = School.paginate(:page => params[:page])
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export
    require 'csv'
    @csv_string = CSV.generate do |csv|
      csv << ['id', 'name', 'state', 'country', 'category', 'is_target']
      School.all.each do |h|
        csv << [h.id,
                h.name,
                h.state,
                h.country,
                h.category,
                h.is_target]
      end
    end
    send_data @csv_string,
              :filename => "schools.csv",
              :type => "text/csv"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    def category_selection
      @categories = ['high_school', 'university']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :state, :country, :category,
                                     :is_target)
    end
end
