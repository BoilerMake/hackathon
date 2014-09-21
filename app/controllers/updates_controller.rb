class UpdatesController < ApplicationController
  skip_before_action :require_login
  load_and_authorize_resource

  def index
    @updates = Update.all.order('created_at DESC')
  end

  def new
    @update = Update.new
  end

  def create
    @update = Update.new(update_params)

    respond_to do |format|
      if @update.save
        format.html { redirect_to updates_path, notice: 'Update posted.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def update_params
    params.require(:update).permit(:title, :body)
  end
end
