class UpdatesController < ApplicationController
  skip_before_action :require_login
  load_and_authorize_resource

  def index
    @updates = Update.all.order('created_at DESC')
  end

  def new
    @update = Update.new
  end

  def edit
    @update = Update.find(params[:update_id])
  end

  def create
    @update = Update.new(update_params)

    respond_to do |format|
      if @update.save
        flash_msg = {flash: {notice: 'Update Posted.'} }
        if @update.should_text?
          @update.send_texts
          @update.text_sent = true
          @update.save
        end
        format.html { redirect_to updates_path, flash_msg }
      else
        format.html { render :new }
      end
    end
  end

  private

  def update_params
    params.require(:update).permit(:title, :body, :short_message, :should_text)
  end
end
