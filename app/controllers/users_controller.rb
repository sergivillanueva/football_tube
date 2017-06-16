class UsersController < ApplicationController
  before_action :check_admin_role, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json do
        @users = User.includes(:favourite_team)
        render "users/index"
      end
    end
  end
end
