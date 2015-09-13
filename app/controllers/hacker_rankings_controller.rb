class HackerRankingsController < ApplicationController
  respond_to :js, :json, :html
  def update
    respond_to do |format|
      @hacker_ranking = HackerRanking.find(params[:id])
      @hacker_ranking.update(ranking_params)
      format.json { render json: @hacker_ranking.to_json }
    end
  end
  def create
    respond_to do |format|
      @hacker_ranking = HackerRanking.create(ranking_params)
      @hacker_ranking.save!
      format.json { render json: @hacker_ranking.to_json }
    end
  end

  def show
    @hacker_ranking = HackerRanking.find(params['id'])
    respond_to do |format|
      format.json { render json: @hacker_ranking.to_json }
    end
  end
  def ranking_params
    params.require(:hacker_ranking).permit(:hacker_id, :exec_id, :ranking)
  end
end
