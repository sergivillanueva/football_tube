class RaterController < ApplicationController
  before_action :check_admin_role, only: [:index]

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]

      render :json => true
    else
      render :json => false
    end
  end

  def index
    respond_to do |format|
      format.html do
        render "rates/index"
      end
      format.json do
        @rates = Rate.includes(:rater).includes(:rateable)
        render "rates/index"
      end
    end
  end
end
