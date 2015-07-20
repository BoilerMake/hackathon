class VisualizationController < ApplicationController
	skip_before_action :require_login
	layout false
  def index
  	@total_apps = Hacker.distinct.count('id');
  end
end
