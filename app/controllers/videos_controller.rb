class VideosController < ApplicationController
  before_action :authenticate_user!
  #TODO use cancancan gem for this and let user crud her own stuff
  before_action :check_admin_role, only: [:destroy, :index]

  def index    
    respond_to do |format|
      format.html
      format.json do
        @videos = Video.includes(:match => [:home_team, :away_team])
        render "videos/index"
      end
    end
  end

  def destroy
    @video = Video.find params[:id]
    @video.destroy
    redirect_to videos_path, notice: "Video deleted"
  rescue Exception => e
    redirect_to videos_path, alert: "Video cannot be deleted: #{e}"
  end

end
