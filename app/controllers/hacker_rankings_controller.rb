class HackerRankingsController < ApplicationController
  respond_to :js, :json, :html

  def create
    @hacker_ranking = HackerRanking.new(ranking_params)
    #respond_with ranking_params.to_json
    respond_to do |format|
      format.json { render json: @hacker_ranking.to_json }
      format.html { render json: @hacker_ranking.to_json }
    end
    #respond_with @hacker_ranking
  end
  def update
    respond_to do |format|
      @hacker_ranking = HackerRanking.find(params[:id])
      @hacker_ranking.update(ranking_params)
      format.json { render json: @hacker_ranking.to_json }
      format.html { render json: @hacker_ranking.to_json }
    end
  end

  def show
    @hacker_ranking = HackerRanking.find(params['id'])
    # render :text =>  @hacker_ranking.to_yaml
    respond_to do |format|
      format.json { render json: @hacker_ranking.to_json }
      format.html { render json: @hacker_ranking.to_json }
    end
  end
  def ranking_params
    params.require(:hacker_ranking).permit(:hacker_id, :exec_id, :ranking)
  end
end
