class HackerRankingsController < ApplicationController
  respond_to :js, :json, :html

  def create
    render :text => params
    #email_address = params['interest_signup']['email'].downcase

    @hacker_ranking = HackerRanking.create(ranking: params[:ranking])

    #respond_with @hacker_ranking
  end
  def show
    @hacker_ranking = HackerRanking.find(params['id'])
    render :text => params['id']
    #render :text =>  @hacker_ranking.to_yaml
    return
  end
end
